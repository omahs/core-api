module Api
  module V1
    module Integrations
      class ImpactsController < ApplicationController
        def index
          formatted_impact = impact_service.formatted_impact

          render json: IntegrationImpactBlueprint.render(formatted_impact), status: :ok
        end

        private

        def start_date
          @start_date ||= params[:start_date]
        end

        def end_date
          @end_date ||= params[:end_date]
        end

        def integration
          @integration ||= Integration.find_by_id_or_unique_address params[:integration_id]
        end

        def impact_service
          @impact_service ||= Service::Integrations::ImpactTrend.new(integration:, start_date:, end_date:)
        end
      end
    end
  end
end
