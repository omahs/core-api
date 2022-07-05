module Adapter
  module Controllers
    module Payment
      class CreditCards
        attr_reader :payment_params, :user

        def initialize(payment_params:, user:)
          @payment_params = payment_params
          @user = user
        end

        def order_params
          { card: credit_card, email: payment_params[:email], tax_id: payment_params[:tax_id],
            offer:, payment_method:, user: find_or_create_user, operation: }
        end

        private

        def payment_method
          :credit_card
        end

        def find_or_create_user
          user || User.find_or_create_by(email: payment_params[:email])
        end

        def offer
          @offer ||= Offer.find payment_params[:offer_id].to_i
        end

        def operation
          return :subscribe if offer.subscription?

          :purchase
        end

        def credit_card
          card = payment_params[:card]

          @credit_card ||= CreditCard.new(cvv: card[:cvv], number: card[:number], name: card[:name],
                                          expiration_month: card[:expiration_month],
                                          expiration_year: card[:expiration_year])
        end
      end
    end
  end
end
