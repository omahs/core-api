module GivingServices
  module Fees
    class FeeCalculatorService
      attr_reader :value, :kind

      def initialize(value:, kind:)
        @value = value
        @kind = kind
      end

      delegate :calculate_fee, to: :calculator_class_factory

      private

      def calculator_class_factory
        calculator_services[kind].new(value: value)
      end

      def calculator_services
        {
          stripe_card: Card::StripeCardFeeCalculatorService
        }
      end
    end
  end
end
