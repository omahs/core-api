class OfferGateway < ApplicationRecord
  belongs_to :offer, inverse_of: :offer_gateway
  validates :gateway, :external_id, presence: true

  enum gateway: {
    stripe: 0
  }
end
