module Api
  module V1
    class NonProfitsController < ApplicationController
      def index
        @non_profits = NonProfit.where(status: :active)

        render json: NonProfitBlueprint.render(@non_profits)
      end
    end
  end
end
