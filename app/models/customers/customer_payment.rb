class CustomerPayment < ApplicationRecord
  include UuidHelper

  PAYMENT_METHODS = %w[credit_card pix crypto].freeze
  STATUSES = %w[processing paid failed].freeze

  after_create :set_fees

  belongs_to :customer
  belongs_to :offer, optional: true
  has_one :customer_payment_blockchain
  has_one :customer_payment_fee

  validates :paid_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES, message: '%<value>s is not a valid status' }
  validates :payment_method, presence: true,
                             inclusion: {
                               in: PAYMENT_METHODS,
                               message: '%<value>s is not a valid payment method'
                             }

  def crypto_amount
    return offer.price_value if offer.usd?

    Currency::Converters.convert_to_usd(value: offer.price_value, from: offer.currency).to_f
  end

  def amount
    return amount_value if amount_cents

    crypto_amount
  end

  def amount_value
    amount_cents / 100.0
  end

  def set_fees
    fees = Givings::Card::CalculateCardGiving.call(value: amount_value, currency:).result
    create_customer_payment_fee!(card_fee_cents: fees[:card_fee].cents,
                                 crypto_fee_cents: fees[:crypto_fee].cents)
  rescue StandardError => e
    Reporter.log(error: e)
  end

  private

  def currency
    offer&.currency || :usd
  end
end
