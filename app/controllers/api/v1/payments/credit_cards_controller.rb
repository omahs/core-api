module Api
  module V1
    module Payments
      class CreditCardsController < ApplicationController
        def subscribe
          command = Givings::Payment::CreateOrder.call(subscription_params)

          if command.success?
            head :ok
          else
            head :unprocessable_entity
          end
        end

        private

        def subscription_params
          { card: credit_card, email: payment_params[:email], national_id: payment_params[:national_id],
            offer_id: payment_params[:offer_id], payment_method: :credit_card, user:, operation: :subscribe }
        end

        def user
          @user ||= current_user || User.find_or_create_by(email: payment_params[:email])
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
