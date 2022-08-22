module Api
  module V1
    class UsersController < ApplicationController
      def search
        @user = User.find_by(email: params[:email])

        if @user
          render json: UserBlueprint.render(@user, view: :extended)
        else
          render json: { error: 'user not found' }, status: :not_found
        end
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: UserBlueprint.render(@user), status: :created
        else
          head :unprocessable_entity
        end
      end

      def can_donate
        @integration = Integration.find params[:integration_id]

        render json: { can_donate: current_user.can_donate?(@integration) }
      end

      private

      def user_params
        params.permit(:email)
      end
    end
  end
end
