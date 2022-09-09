# == Schema Information
#
# Table name: person_payments
#
#  id             :bigint           not null, primary key
#  amount_cents   :integer
#  paid_date      :datetime
#  payment_method :integer
#  status         :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  offer_id       :bigint
#  person_id      :uuid
#
# Indexes
#
#  index_person_payments_on_offer_id   (offer_id)
#  index_person_payments_on_person_id  (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (offer_id => offers.id)
#  fk_rails_...  (person_id => people.id)
#
class PersonPayment < ApplicationRecord
  include UuidHelper

  PAYMENT_METHODS = %w[credit_card pix crypto].freeze
  STATUSES = %w[processing paid failed].freeze

  after_create :set_fees

  belongs_to :person
  belongs_to :offer, optional: true
  has_one :person_blockchain_transaction
  has_one :person_payment_fee

  validates :paid_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES, message: '%<value>s is not a valid status' }
  validates :payment_method, presence: true,
                             inclusion: {
                               in: PAYMENT_METHODS,
                               message: '%<value>s is not a valid payment method'
                             }

  def crypto_amount
    amount_with_fees = amount - service_fees
    return amount_with_fees if currency == :usd

    Currency::Converters.convert_to_usd(value: amount_with_fees, from: currency).to_f
  end

  def amount
    return amount_value if amount_cents

    offer&.price_value
  end

  def amount_value
    amount_cents / 100.0
  end

  def set_fees
    fees = Givings::Card::CalculateCardGiving.call(value: amount_value, currency:).result
    create_person_payment_fee!(card_fee_cents: fees[:card_fee].cents,
                               crypto_fee_cents: fees[:crypto_fee].cents)
  rescue StandardError => e
    Reporter.log(error: e)
  end

  private

  def currency
    offer&.currency&.to_sym&.downcase || :usd
  end

  def service_fees
    person_payment_fee&.service_fee || 0
  end
end
