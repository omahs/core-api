# == Schema Information
#
# Table name: offer_gateways
#
#  id          :bigint           not null, primary key
#  gateway     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :string
#  offer_id    :bigint           not null
#
# Indexes
#
#  index_offer_gateways_on_offer_id  (offer_id)
#
# Foreign Keys
#
#  fk_rails_...  (offer_id => offers.id)
#
class OfferGateway < ApplicationRecord
  belongs_to :offer, inverse_of: :offer_gateway
  validates :gateway, :external_id, presence: true

  enum gateway: {
    stripe: 0
  }
end
