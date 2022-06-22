module Api
  module V1
    module Givings
      class SubscriptionsController < ApplicationController
        def credit_card_create
          command = Givings::Payment::CreateOrder
                    .call(card: credit_card, email: payment_params[:email],
                          national_id: payment_params[:national_id],
                          offer_id: payment_params[:offer_id],
                          payment_method: :credit_card, user: current_user,
                          operation:)

          if command.success?
            head :ok
          else
            head :unprocessable_entity
          end
        end

        private

        def operation
          :subscribe
        end

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
