module GivingServices
  module Fees
    module Card
      class StripeCardFeeCalculatorService
        attr_reader :value, :currency

        STRIPE_PERCENTAGE_FEE = 0.0399
        STRIPE_FIXED_FEE = 0.39 # brl

        def initialize(value:, currency:)
          @value = value
          @currency = currency
        end

        def calculate_fee
          percentage_fee + fixed_fee
        end

        private

        def percentage_fee
          value * STRIPE_PERCENTAGE_FEE
        end

        def fixed_fee
          return STRIPE_FIXED_FEE if paying_in_brl?

          Currency::Converters.new(value: STRIPE_FIXED_FEE, from: currency, to: 'BRL')
                              .convert
                              .to_f
        end

        def converted_value
          return value if paying_in_brl?

          currency_service = Currency::Converters.new(value: value, from: currency, to: 'BRL')
          currency_service.convert.to_f
        end

        def paying_in_brl?
          currency.eql?('BRL')
        end
      end
    end
  end
end
