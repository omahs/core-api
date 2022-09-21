module Integrations
  module V1
    class DonationsController < Integrations::IntegrationsController
      def index
        donations = current_integration.donations

        render json: DonationBlueprint.render(donations, view: :integrations), status: :ok
      end

      def show
        donation = current_integration.donations.find params[:id]

        render json: DonationBlueprint.render(donation), status: :ok
      end
    end
  end
end
