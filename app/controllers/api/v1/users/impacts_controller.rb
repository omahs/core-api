module Api
  module V1
    module Users
      class ImpactsController < ApplicationController
        def index
          render json: UserImpactBlueprint.render(user.impact)
        end

        private

        def user
          @user ||= User.find params[:user_id]
        end
      end
    end
  end
end
