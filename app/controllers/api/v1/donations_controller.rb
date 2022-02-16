module Api
  module V1
    class DonationsController < ApplicationController
      def create
        command = Donations::Donate.call(integration: integration, non_profit: non_profit)

        if command.success?
          head :ok
        else
          head :unprocessable_entity
        end
      end

      private

      def integration
        @integration ||= Integration.find donation_params[:integration_id]
      end

      def non_profit
        @non_profit ||= NonProfit.find donation_params[:non_profit_id]
      end

      def donation_params
        params.permit(:integration_id,
                      :non_profit_id)
      end
    end
  end
end
