module Api
  module V1
    module Payments
      class CreditCardsController < ApplicationController
        include Adapter::Controllers::Payment::CreditCards

        def create
          command = ::Givings::Payment::CreateOrder.call(order_params)

          if command.success?
            head :created
          else
            render_errors(command.errors)
          end
        end

        private

        def payment_params
          params.permit(:email, :tax_id, :offer_id, :country, :city, :state,
                        card: %i[cvv number name expiration_month expiration_year])
        end
      end
    end
  end
end
