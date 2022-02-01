module Api
  module V1
    class NgosController < ApplicationController
      def index
        @ngos = Ngo.all

        render json: @ngos
      end
    end
  end
end
