module Api
  module V1
    module Payments
      class CreditCardsController < ApplicationController
        include ::Givings::Payment

        def create
          command = ::Givings::Payment::CreateOrder.call(OrderTypes::CreditCard, order_params)

          if command.success?
            head :created
          else
            render_errors(command.errors)
          end
        end

        private

        def order_param
          {
            card: CreditCard.new(cvv: '411',
              number: '4111111111111111',
              name: 'User Test',
              expiration_month: '08',
              expiration_year: '22'),
            email: 'user@gmail.com',
            offer: Offer.last,
            operation: :purchase,
            payment_method: :credit_card,
            tax_id: '123456789',
            user: User.last
          }
        end

        def card
          @card ||= CreditCard.from(payment_params[:card])
        end

        def find_or_create_user
          current_user || User.find_or_create_by(email: payment_params[:email])
        end

        def offer
          @offer ||= Offer.find payment_params[:offer_id].to_i
        end

        def operation
          return :subscribe if offer.subscription?

          :purchase
        end

        def payment_params
          params.permit(:email, :tax_id, :offer_id, :country, :city, :state,
                        card: %i[cvv number name expiration_month expiration_year])
        end
      end
    end
  end
end
