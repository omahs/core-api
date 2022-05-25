module GivingServices
  module Taxes
    class TaxCalculatorService
      attr_reader :value, :kind

      def initialize(value:, kind:)
        @value = value
        @kind = kind
      end

      delegate :calculate_tax, to: :calculator_class_factory

      private

      def calculator_class_factory
        calculator_services[kind].new(value: value)
      end

      def calculator_services
        {
          card: CardTaxCalculatorService,
          crypto: CryptoTaxCalculatorService
        }
      end
    end
  end
end
