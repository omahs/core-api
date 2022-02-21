module Api
  module V1
    class IntegrationsController < ApplicationController
      def show
        @integration = Integration.find params[:id]

        render json: IntegrationBlueprint.render(@integration)
      end
    end
  end
end
