module Payment
  module Stripe
    class Base
      def initialize
        ::Stripe.api_key = RibonCoreApi.config[:stripe][:secret_key]
      end
    end
  end
end
