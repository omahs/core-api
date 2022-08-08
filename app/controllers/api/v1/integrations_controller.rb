module Api
  module V1
    class IntegrationsController < ApplicationController
      def index
        @integrations = Integration.all

        render json: IntegrationBlueprint.render(@integrations)
      end

      def create
        command = Integrations::CreateIntegration.call(name: params[:name], status: params[:status])

        if command.success?
          render json: IntegrationBlueprint.render(command.result), status: :created
        else
          render_errors(command.errors)
        end
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
