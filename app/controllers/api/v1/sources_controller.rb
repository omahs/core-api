module Api
  module V1
    class SourcesController < ApplicationController
      def create
        @source = Source.new(source_params)

        if @source.save
          render json: SourceBlueprint.render(@source), status: :created
        else
          head :unprocessable_entity
        end
      end

      private

      def source_params
        params.permit(:integration_id, :user_id)
      end
    end
  end
end
