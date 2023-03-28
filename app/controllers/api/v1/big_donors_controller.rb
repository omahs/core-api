module Api
  module V1
    class BigDonorsController < ApplicationController
      def index
        @big_donors = BigDonor.all

        render json: BigDonorBlueprint.render(@big_donors)
      end
    end
  end
end
