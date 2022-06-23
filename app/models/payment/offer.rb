class Offer < ApplicationRecord
  has_one :offer_gateway, dependent: :nullify, inverse_of: :offer
  accepts_nested_attributes_for :offer_gateway, allow_destroy: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true
  validates :subscription, inclusion: [true, false]

  delegate :gateway, to: :offer_gateway
  delegate :external_id, to: :offer_gateway

  enum currency: {
    brl: 0,
    usd: 1
  }

  def price_value
    price_cents / 100.0
  end
end
