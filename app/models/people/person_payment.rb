class PersonPayment < ApplicationRecord
  include UuidHelper

  PAYMENT_METHODS = %w[credit_card pix crypto].freeze
  STATUSES = %w[processing paid failed].freeze

  belongs_to :person
  belongs_to :offer, optional: true
  has_one :person_blockchain_transaction

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
end
