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
        tax_methods = {
          card: CardTaxCalculatorService,
          crypto: CryptoTaxCalculatorService
        }

        tax_methods[kind].new(value: value)
      end
    end
  end
end
