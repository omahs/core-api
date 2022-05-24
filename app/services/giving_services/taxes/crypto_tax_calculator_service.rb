module GivingServices
  module Taxes
    class CryptoTaxCalculatorService
      attr_reader :value

      def initialize(value:)
        @value = value
      end

      def calculate_tax
        value * 4.5
      end
    end
  end
end
