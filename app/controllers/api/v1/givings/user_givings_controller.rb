module Api
  module V1
    module Givings
      class UserGivingsController < ApplicationController
        def index
          @customer = Customer.find_by(email: params[:email])
          render json: CustomerPaymentBlueprint.render(givings)
        end

        private

        def givings
          @givings ||= PersonPayment.where(status: :paid, person: @customer.person)
        end
      end
    end
  end
end
