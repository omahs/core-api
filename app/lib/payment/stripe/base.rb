module Payment
  module Stripe
    class Base
      def initialize
        ::Stripe.api_key = RibonBackend.config[:stripe][:secret_key]
      end
    end
  end
end
