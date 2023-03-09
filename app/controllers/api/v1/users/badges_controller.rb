module Api
  module V1
    module Users
      class BadgesController < ApplicationController
        def index
          @badges = Badge.all.order(id: :asc)

          render json: badges_with_claimed
        end

        def points
          streak = user.donations.distinct.pluck('date(created_at)').count

          render json: { points: user.points, level: user.level, streak: }
        end

        private

        def user
          @user ||= User.find params[:user_id]
        end

        def badges_with_claimed
          user_badges_ids = user.badge_ids

          @badges_with_claimed ||= @badges.map do |badge|
            badge.attributes.merge({ claimed: user_badges_ids.include?(badge.id),
                                     image: ImagesHelper.image_url_for(badge.image) })
          end
        end
      end
    end
  end
end
