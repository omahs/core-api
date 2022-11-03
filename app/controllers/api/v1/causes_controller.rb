module Api
  module V1
    class CausesController < ApplicationController
      def index
        @causes = Cause.all

        render json: CauseBlueprint.render(@causes)
      end

      def show
        @cause = Cause.find_by cause_integration_query

        render json: CauseBlueprint.render(@cause)
      end

      def cause_params
        params.permit(:id)
      end

      def cause_integration_query
        uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

        return { unique_address: cause_params[:id] } if uuid_regex.match?(cause_params[:id])

        { id: cause_params[:id] }
      end
    end
  end
end
