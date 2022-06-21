module Api
  module V1
    module Givings
      class SubscriptionsController < ApplicationController
        def create; end

        private

        def credit_card
          card = payment_params[:card]

          @credit_card ||= CreditCard.new(cvv: card[:cvv], number: card[:number], name: card[:name],
                                          expiration_month: card[:expiration_month],
                                          expiration_year: card[:expiration_year])
        end

        def payment_params
          params.permit(:email, :national_id, :offer_id, :country,
                        :city, :state, :payment_method,
                        card: %i[cvv number name expiration_month expiration_year])
        end
      end
    end
  end
end
