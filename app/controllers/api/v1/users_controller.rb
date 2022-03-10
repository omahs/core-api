module Api
  module V1
    class UsersController < ApplicationController
      def search
        @user = User.find_by(email: params[:email])

        if @user
          render json: UserBlueprint.render(@user)
        else
          render json: { error: 'user not found' }, status: :not_found
        end
      end

      def impact
        @user = User.first
        @impacts = @user.impact

        if @user
          render json: UserBlueprint.render(@impacts)
        else
          render json: { error: 'User not found' }, status: :not_found
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

      private

      def user_params
        params.permit(:email)
      end
    end
  end
end
