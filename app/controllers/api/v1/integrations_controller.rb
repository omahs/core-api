module Api
  module V1
    class IntegrationsController < ApplicationController
      def index
        @integrations = Integration.all

        render json: IntegrationBlueprint.render(@integrations)
      end

      def show
        @integration = Integration.find params[:id]

        render json: IntegrationBlueprint.render(@integration)
      end
    end
  end
end
