module GivingServices
  module Taxes
    module Card
      class StripeCardTaxCalculatorService
        attr_reader :value

        def initialize(value:)
          @value = value
        end

        def calculate_tax
          percentage_tax + fixed_tax
        end

        private

        def percentage_tax
          value * 0.0399
        end

        def fixed_tax
          0.39
        end
      end
    end
  end
end
