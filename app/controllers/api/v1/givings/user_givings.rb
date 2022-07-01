module Api
  module V1
    module Givings
      class UserGivingsController < ApplicationController
        def index
          @customer = Customer.find_by(email: params[:email])
          render json: CustomerPaymentsBlueprint.render(givings)
        end

        private

        def givings
          @givings ||= @customer.customer_payments.where(status: :paid)
        end

        def currency
          @currency ||= params[:currency]&.downcase&.to_sym
        end
      end
    end
  end
end
