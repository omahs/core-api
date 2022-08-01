module Api
  module V1
    class IntegrationsController < ApplicationController
      def index
        @integrations = Integration.all

        render json: IntegrationBlueprint.render(@integrations)
      end

      def create
        command = Integrations::CreateIntegration.call(name: params[:name], status: params[:status].to_i)

        if command.success?
          render json: IntegrationBlueprint.render(command.result), status: :created
        else
          render_errors(command.errors)
        end
      end

      def show
        @integration = Integration.find params[:id]

        render json: IntegrationBlueprint.render(@integration)
      end
    end
  end
end
