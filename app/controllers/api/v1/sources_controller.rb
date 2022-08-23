module Api
  module V1
    class SourcesController < ApplicationController
      before_action :check_if_user_has_source

      def create
        @source = Source.new(source_params)

        if @source.save
          render json: SourceBlueprint.render(@source), status: :created
        else
          head :unprocessable_entity
        end
      end

      private

      def check_if_user_has_source
        return if Source.where(user_id: params[:user_id]).blank?

        render json: { message: I18n.t('sources.has_source_message') }, status: :unprocessable_entity
      end

      def source_params
        params.permit(:integration_id, :user_id)
      end
    end
  end
end
