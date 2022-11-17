module Offers
  class CreateOffer < ApplicationCommand
    prepend SimpleCommand
    attr_reader :offer_params

    def initialize(offer_params)
      @offer_params = offer_params
    end

    def call
      if offer_params[:id].present?
        update
      else
        create
      end
    end

    private

    def create_offer_gateway
      OfferGateway.create!({ external_id: offer_params[:external_id], gateway: offer_params[:gateway] })
    end

    def create
      offer = Offer.create!(currency: 'brl', price_cents: 1,
                            active: offer_params[:active], subscription: offer_params[:active])
      OfferGateway.create!(external_id: offer_params[:external_id], gateway: offer_params[:gateway], offer:)
      offer
    end

    def update
      offer = Offer.find offer_params[:id]
      offer.update(currency: offer_params[:currency], price_cents: offer_params[:price_cents],
                   active: offer_params[:active], subscription: offer_params[:active])
      gateway = OfferGateway.find_by(offer:)
      gateway.update(external_id: offer_params[:external_id], gateway: offer_params[:gateway])
      offer
    end
  end
end
