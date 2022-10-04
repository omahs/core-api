module Integrations
  module V1
    class DonationsController < IntegrationsController
      def index
        donations = current_integration.donations

        render json: DonationBlueprint.render(donations, view: :minimal), status: :ok
      end

      def show
        donation = current_integration.donations.find params[:id]

        render json: DonationBlueprint.render(donation, view: :minimal), status: :ok
      end
    end
  end
end
