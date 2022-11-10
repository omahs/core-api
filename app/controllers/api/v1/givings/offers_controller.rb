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

        private

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
