module Offers
  class UpsertOffer < ApplicationCommand
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

    def create
      Offer.create!(offer_params)
    end

    def update
      offer = Offer.find offer_params[:id]
      offer.update!(offer_params)
      offer
    end
  end
end
