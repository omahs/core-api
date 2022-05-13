module Api
  module V1
    class GivingValuesController < ApplicationController
      def index
        @giving_values = GivingValue.where(currency: params[:currency]).order(value: :asc)

        render json: GivingValueBlueprint.render(@giving_values)
      end
    end
  end
end
