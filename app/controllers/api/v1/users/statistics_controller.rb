module Api
  module V1
    module Users
      class StatisticsController < ApplicationController
        delegate :total_causes, :total_non_profits, :total_donated,
                 to: :statistics_service
        def index
          donated = total_donated if customer
          render json: { total_non_profits:, total_tickets: donations.count,
                         total_donated: donated || 0,
                         total_causes: }
        end

        private

        def user
          @user ||= User.find params[:user_id]
        end

        def customer
          Customer.find_by(email: user.email)
        end

        def donations
          @donations = user.donations
        end

        def statistics_service
          @statistics_service ||= Service::Users::Statistics.new(donations:, user:, customer:)
        end
      end
    end
  end
end
