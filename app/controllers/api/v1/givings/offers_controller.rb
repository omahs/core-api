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
          @offer = Offer.find_by offer_query

          render json: OfferBlueprint.render(@offer)
        end

        def create
          command = ::Offers::UpsertOffer.call(offer_params)
          if command.success?
            render json: OfferBlueprint.render(command.result), status: :created
          else
            render_errors(command.errors)
          end
        end

        def update
          command = ::Offers::UpsertOffer.call(offer_params)
          if command.success?
            render json: OfferBlueprint.render(command.result), status: :created
          else
            render_errors(command.errors)
          end
        end

        private

        def currency
          params[:currency] || :brl
        end

        def subscription
          params[:subscription] || false
        end

        def offer_params
          params.permit(:id, :price_cents, :gateway, :currency, :external_id, :active)
        end

        def offer_query
          uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

          return { unique_address: offer_params[:id] } if uuid_regex.match?(offer_params[:id])

          { id: offer_params[:id] }
        end
      end
    end
  end
end
