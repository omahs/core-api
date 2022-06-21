module Service
  module Givings
    module Payment
      class Orchestrator
        attr_reader :order

        def initialize(order:)
          @order = order
        end

        def process
          gateway_instance = GatewayFactory.new(order.gateway)

          return create_subscription(gateway_instance) if order.offer.subscription?

          create_giving(gateway_instance)
        end

        private

        def create_subscription(_gateway_instance)
          Rails.logger.debug('Creacte Subscription')
        end

        def create_giving(_gateway_instance)
          Rails.logger.debug('Creacte Giving')
        end
      end
    end
  end
end
