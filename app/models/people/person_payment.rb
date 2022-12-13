# == Schema Information
#
# Table name: person_payments
#
#  id             :bigint           not null, primary key
#  amount_cents   :integer
#  error_code     :string
#  paid_date      :datetime
#  payment_method :integer
#  receiver_type  :string
#  refund_date    :datetime
#  status         :integer          default("processing")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  external_id    :string
#  integration_id :bigint
#  offer_id       :bigint
#  person_id      :uuid
#  receiver_id    :bigint
#
class PersonPayment < ApplicationRecord
  include UuidHelper

  after_create :set_fees

  belongs_to :person
  belongs_to :integration
  belongs_to :offer, optional: true
  belongs_to :receiver, polymorphic: true, optional: true

  has_one :person_blockchain_transaction
  has_one :person_payment_fee

  validates :paid_date, :status, :payment_method, presence: true

  enum status: {
    processing: 0,
    paid: 1,
    failed: 2,
    refunded: 3,
    refund_failed: 4
  }

  enum payment_method: {
    credit_card: 0,
    pix: 1,
    crypto: 2
  }

  def crypto_amount
    amount_with_fees = amount - service_fees
    return amount_with_fees if currency == :usd

    Currency::Converters.convert_to_usd(value: amount_with_fees, from: currency).round.to_f
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
