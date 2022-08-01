module Api
  module V1
    class IntegrationsController < ApplicationController
      def index
        @integrations = Integration.all

        render json: IntegrationBlueprint.render(@integrations)
      end

      def show
        @integration = Integration.find integration_params[:id]

        render json: IntegrationBlueprint.render(@integration)
      end

      def update
        @integration = Integration.find integration_params[:id]
        @integration.update(integration_params)

        render json: IntegrationBlueprint.render(@integration)
      end

      private

      def integration_params
        params.permit(:name, :status, :id)
      end
    end
  end
end
