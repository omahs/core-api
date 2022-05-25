module GivingServices
  module Fees
    module Card
      class StripeCardFeeCalculatorService
        attr_reader :value

        def initialize(value:)
          @value = value
        end

        def calculate_fee
          percentage_fee + fixed_fee
        end

        private

        def percentage_fee
          value * 0.0399
        end

        def fixed_fee
          0.39
        end
      end
    end
  end
end
