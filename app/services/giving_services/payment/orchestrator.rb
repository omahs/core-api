module GivingServices
  module Payment
    class Orchestrator
      attr_reader :payload

      def initialize(payload:)
        @payload = payload
      end

      def call
        ::Payment::Entrypoint.new(gateway: gateway).process(operation: operation, payload: payload)
      end

      private

      def gateway
        GatewayFactory.new(payload.gateway).call
      end

      def operation
        payload.operation
      end
    end
  end
end
