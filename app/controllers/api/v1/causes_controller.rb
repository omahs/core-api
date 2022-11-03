module Api
  module V1
    class CausesController < ApplicationController
      def index
        @causes = Cause.all

        render json: CauseBlueprint.render(@causes)
      end

      def create
        command = Causes::CreateCause.call(cause_params)
        if command.success?
          render json: CauseBlueprint.render(command.result), status: :created
        else
          render_errors(command.errors)
        end
      end

      def show
        @cause = Cause.find(cause_params[:id])

        render json: CauseBlueprint.render(@cause)
      end

      def update
        command = Causes::UpdateCause.call(cause_params)
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

    end
  end
end
