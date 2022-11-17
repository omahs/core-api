module Offers
  class UpsertOffer < ApplicationCommand
    prepend SimpleCommand
    attr_reader :id, :currency, :price_cents, :active, :external_id, :gateway

    def initialize(args)
      @id = args[:id]
      @currency = args[:currency]
      @price_cents = args[:price_cents]
      @active = args[:active]
      @gateway = args[:gateway]
      @external_id = args[:external_id]
    end

    def call
      if id.present?
        update
      else
        create
      end
    end

    private

    def create
      offer = Offer.create!(currency:, price_cents:, active:)

      OfferGateway.create!(external_id:, gateway:, offer:)
      offer
    end

    def update
      offer = Offer.find id
      offer.update!(currency:, price_cents:, active:)
      offer_gateway = OfferGateway.find_by(offer:)

      offer_gateway.update(external_id:, gateway:)
      offer
    end
  end
end
