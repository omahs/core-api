module Payment
  module Gateways
    module GatewayBuilder
      extend self

      def stripe_service
        @stripe_service ||= ::Payment::Stripe::Service.new
      end
    end
  end
end
  