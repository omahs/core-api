module Api
  module V1
    class NonProfitsController < ApplicationController
      def index
        @non_profits = NonProfit.where(status: :active)

        render json: NonProfitBlueprint.render(@non_profits)
      end

      def stories
        @non_profit = NonProfit.find(params[:id])
        @stories = @non_profit.stories.where(active: true).order(position: :asc)

        render json: StoryBlueprint.render(@stories, view: :minimal)
      end
    end
  end
end
