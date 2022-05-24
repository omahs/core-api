module GivingServices
  module Taxes
    class CardTaxCalculatorService
      attr_reader :value

      def initialize(value:)
        @value = value
      end

      def calculate_tax
        value * 1.5
      end
    end
  end
end
