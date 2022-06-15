module GivingServices
  module Payment
    class GatewayFactory
      include ::Payment::GatewayBuilder

      def purchase(order)
        service_for(order).purchase(order)
      end

      private

      def service_for(order)
        send(service_method(order&.gateway))
      end

      def service_method(gateway)
        "#{gateway}_service".to_sym
      end
    end
  end
end