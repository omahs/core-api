class CustomerPayment < ApplicationRecord
  include UuidHelper

  PAYMENT_METHODS = %w[credit_card pix crypto].freeze
  STATUSES = %w[processing paid failed].freeze

  belongs_to :customer
  belongs_to :offer
  has_one :customer_payment_blockchain

  validates :paid_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES, message: '%<value>s is not a valid status' }
  validates :payment_method, presence: true,
                             inclusion: {
                               in: PAYMENT_METHODS,
                               message: '%<value>s is not a valid payment method'
                             }
end