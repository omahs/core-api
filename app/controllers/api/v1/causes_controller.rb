module Api
  module V1
    class CausesController < ApplicationController
      def index
        @causes = Cause.all

        render json: CauseBlueprint.render(@causes)
      end

      def create
        command = Causes::UpsertCause.call(cause_params)
        if command.success?
          render json: CauseBlueprint.render(command.result), status: :created
        else
          render_errors(command.errors)
        end
      end

      def show
        @cause = Cause.find_by cause_query

        render json: CauseBlueprint.render(@cause)
      end

      def update
        command = Causes::UpsertCause.call(cause_params)
        if command.success?
          render json: CauseBlueprint.render(command.result), status: :ok
        else
          render_errors(command.errors)
        end
      end

      private

      def cause_params
        params.permit(:id, :name)
      end

      def cause_query
        uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

        return { unique_address: cause_params[:id] } if uuid_regex.match?(cause_params[:id])

        { id: cause_params[:id] }
      end
    end
  end
end
