module Adapter
  module Controllers
    module Payment
      class Cryptocurrencies
        attr_reader :payment_params, :user

        def initialize(payment_params:, user:)
          @payment_params = payment_params
          @user = user
        end

        def order_params
          { email: payment_params[:email], payment_method:, user: find_or_create_user,
            amount: payment_params[:amount], transaction_hash: payment_params[:transaction_hash] }
        end

        private

        def payment_method
          :crypto
        end

        def find_or_create_user
          user || User.find_or_create_by(email: payment_params[:email])
        end
      end
    end
  end
end
