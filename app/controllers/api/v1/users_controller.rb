module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.new(user_params)

        if @user.save
          head :created
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
