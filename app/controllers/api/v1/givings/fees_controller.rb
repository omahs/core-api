module Api
  module V1
    module Givings
      class FeesController < ApplicationController
        def calculate
          command = ::Givings::Card::CalculateStripeGiving.call(value: value,
                                                                currency: currency)

          if command.success?
            render json: GivingFeeBlueprint.render(command.result), status: :ok
          else
            render_errors(command.errors)
          end
        end

        private

        def value
          @value ||= params[:value]
        end

        def currency
          @currency ||= params[:currency].to_sym
        end
      end
    end
  end
end
