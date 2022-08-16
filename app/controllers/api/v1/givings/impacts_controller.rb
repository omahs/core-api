module Api
  module V1
    module Givings
      class ImpactsController < ApplicationController
        def impact_by_non_profit
          command = Givings::Impact::CalculateImpactToNonProfit.call(value:, non_profit:, currency:)

          if command.success?
            render json: command.result
          else
            render_errors(command.errors)
          end
        end

        private

        def value
          @value ||= params[:value].to_f
        end

        def currency
          @currency ||= params[:currency]&.downcase&.to_sym
        end

        def non_profit
          @non_profit ||= NonProfit.find params[:non_profit_id]
        end
      end
    end
  end
end
