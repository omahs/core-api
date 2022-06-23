module Api
  module V1
    module Payments
      class CreditCardsController < ApplicationController
        def subscribe
          command = ::Givings::Payment::CreateOrder.call(subscription_params)

          if command.success?
            head :created
          else
            head :unprocessable_entity
          end
        end

        def purchase
          command = ::Givings::Payment::CreateOrder.call(purchase_params)

          if command.success?
            head :created
          else
            head :unprocessable_entity
          end
        end

        private

        def purchase_params
          { card: credit_card, email: payment_params[:email], tax_id: payment_params[:tax_id],
            offer:, payment_method:, user:, operation: :purchase }
        end

        def subscription_params
          { card: credit_card, email: payment_params[:email], tax_id: payment_params[:tax_id],
            offer:, payment_method:, user:, operation: :subscribe }
        end

        def payment_method
          :credit_card
        end

        def user
          @user ||= current_user || User.find_or_create_by(email: payment_params[:email])
        end

        def offer
          @offer ||= Offer.find payment_params[:offer_id].to_i
        end

        def credit_card
          card = payment_params[:card]

          @credit_card ||= CreditCard.new(cvv: card[:cvv], number: card[:number], name: card[:name],
                                          expiration_month: card[:expiration_month],
                                          expiration_year: card[:expiration_year])
        end

        def payment_params
          params.permit(:email, :tax_id, :offer_id, :country, :city, :state,
                        card: %i[cvv number name expiration_month expiration_year])
        end
      end
    end
  end
end
