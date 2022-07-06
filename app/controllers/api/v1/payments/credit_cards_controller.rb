module Api
  module V1
    module Payments
      class CreditCardsController < ApplicationController
        def create
          command = ::Givings::Payment::CreateOrder.call(order_params)

          if command.success?
            head :created
          else
            render_errors(command.errors)
          end
        end

        private

        def order_params
          Adapter::Controllers::Payment::CreditCards
            .new(payment_params:, user: current_user).order_params
        end

        def payment_params
          params.permit(:email, :tax_id, :offer_id, :country, :city, :state,
                        card: %i[cvv number name expiration_month expiration_year])
        end
      end
    end
  end
end
