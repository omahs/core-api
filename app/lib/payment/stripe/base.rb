module Payment
  module Stripe
    class Base
      ALLOWED_PAYMENT_METHODS = {
        card: 'card'
      }.freeze

      def initialize
        ::Stripe.api_key = RibonCoreApi.config[:stripe][:secret_key]
      end
    end
  end
end
