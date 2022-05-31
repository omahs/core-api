module Api
  module V1
    module Givings
      class FeesController < ApplicationController
        def calculate
          command = ::Givings::Card::CalculateStripeGiving.call(value: params[:value],
                                                                currency: params[:currency])

          if command.success?
            render json: GivingFeeBlueprint.render(command.result), status: :ok
          else
            render_errors(command.errors)
          end
        end
      end
    end
  end
end
