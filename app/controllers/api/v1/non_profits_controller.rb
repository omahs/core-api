module Api
  module V1
    class NonProfitsController < ApplicationController
      def index
        @non_profits = NonProfit.all

        render json: @non_profits
      end
    end
  end
end
