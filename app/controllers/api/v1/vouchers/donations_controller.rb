module Api
  module V1
    module Vouchers
      class DonationsController < ApplicationController
        def create
          command = Vouchers::Donate.call(donation_command:, integration:, external_id:)

          if command.success?
            render json: { donation: command.result }, status: :ok
          else
            render_errors(command.errors)
          end
        end

        private

        def integration
          @integration ||= Integration.find donation_params[:integration_id]
        end

        def non_profit
          @non_profit ||= NonProfit.find donation_params[:non_profit_id]
        end

        def user
          @user ||= User.find_by(email: donation_params[:email])
        end

        def external_id
          @external_id ||= donation_params[:external_id]
        end

        def donation_command
          Donations::Donate.new(integration:, non_profit:, user:)
        end

        def donation_params
          params.permit(:integration_id, :non_profit_id, :email, :external_id)
        end
      end
    end
  end
end
