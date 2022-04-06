module Api
  module V1
    module Users
      class ImpactsController < ApplicationController
        def index
          render json: UserImpactBlueprint.render(user.impact)
        end

        def donations_count
          render json: { donations_count: donations.count }
        end

        private

        def user
          @user ||= User.find params[:user_id]
        end

        def donations
          @donations ||= user.donations
        end
      end
    end
  end
end
