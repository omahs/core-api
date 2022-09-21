module Integrations
  module V1
    class DonationsController < Integrations::IntegrationsController
      def index
        donations = Donation.where(integration: current_integration)

        render json: DonationBlueprint.render(donations, view: :integrations), status: :ok
      end

      def show
        donation = Donation.find params[:id]

        render json: donation, status: :ok
      end
    end
  end
end
