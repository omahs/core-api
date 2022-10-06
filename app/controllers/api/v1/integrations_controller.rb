module Api
  module V1
    class IntegrationsController < ApplicationController
      def index
        @integrations = Integration.all

        render json: IntegrationBlueprint.render(@integrations)
      end

      def mobility_attributes
        render json: IntegrationTask.mobility_attributes
      end

      def create
        command = Integrations::CreateIntegration.call(integration_params)
        if command.success?
          render json: IntegrationBlueprint.render(command.result), status: :created
        else
          render_errors(command.errors)
        end
      end

      def show
        @integration = Integration.find_by fetch_integration_query

        render json: IntegrationBlueprint.render(@integration)
      end

      def update
        @integration = Integration.find integration_params[:id]
        @integration.update(integration_params)
        render json: IntegrationBlueprint.render(@integration)
      end

      private

      def integration_params
        params.permit(:name, :status, :id, :ticket_availability_in_minutes, :logo, :webhook_url,
                      integration_tasks_attributes: %i[id description link link_address])
      end

      def fetch_integration_query
        uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

        return { unique_address: integration_params[:id] } if uuid_regex.match?(integration_params[:id])

        { id: integration_params[:id] }
      end
    end
  end
end
