module Api
  module V1
    module Users
      class TrackingsController < ApplicationController
        include Trackable

        def track_user
          track(trackable: current_user, utm_params:)

          head :ok
        end

        private

        def utm_params
          @utm_params ||= { source: params[:utm][:source], medium: params[:utm][:medium],
                            campaign: params[:utm][:campaign] }
        end
      end
    end
  end
end
