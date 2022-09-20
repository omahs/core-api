module Integrations
  module V1
    class DonationsController < Integrations::IntegrationsController
      def index
        donations = Donation.where(integration: current_integration)

        render json: donations, status: :ok
      end
    end
  end
end
