module Api
  module V1
    module Users
      class BadgesController < ApplicationController
        def index
          @badges = user.badges

          render json: BadgeBlueprint.render(@badges)
        end

        private

        def user
          @user ||= User.find params[:user_id]
        end
      end
    end
  end
end
