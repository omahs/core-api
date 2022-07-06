module Adapter
  module Controllers
    module Payment
      module Cryptocurrencies
        private

        def order_params
          { email: payment_params[:email], payment_method:, user:, amount: payment_params[:amount],
            transaction_hash: payment_params[:transaction_hash] }
        end

        def payment_method
          :crypto
        end

        def user
          @user ||= current_user || User.find_or_create_by(email: payment_params[:email])
        end
      end
    end
  end
end
