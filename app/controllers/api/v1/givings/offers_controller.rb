module Api
  module V1
    module Givings
      class OffersController < ApplicationController
        def index
          @offers = Offer.where(active: true, currency:, subscription:)
                         .order('position_order ASC, price_cents ASC')

          render json: OfferBlueprint.render(@offers, view: :minimal)
        end

        def index_manager
          @offers = Offer.order('position_order ASC, price_cents ASC')

          render json: OfferBlueprint.render(@offers)
        end

        def show
          @offer = Offer.find_by(id: params[:id])

          render json: OfferBlueprint.render(@offer, view: :minimal)
        end

        private

        def offer_params
          params.permit(:id)
        end

        def currency
          params[:currency] || :brl
        end

        def subscription
          params[:subscription] || false
        end
      end
    end
  end
end
