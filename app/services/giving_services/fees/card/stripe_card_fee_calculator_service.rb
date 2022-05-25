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
          brl_value = percentage_fee_brl + fixed_fee_brl
          return brl_value if paying_in_brl?

          convert_from_brl(brl_value)
        end

        private

        def percentage_fee_brl
          value_in_brl * STRIPE_PERCENTAGE_FEE
        end

        def fixed_fee_brl
          STRIPE_FIXED_FEE
        end

        def value_in_brl
          return value if paying_in_brl?

          convert_to_brl(value)
        end

        def paying_in_brl?
          currency.eql?('BRL')
        end

        def convert_to_brl(amount)
          Currency::Converters.new(value: amount, from: currency, to: 'BRL')
                              .convert
                              .to_f
        end

        def convert_from_brl(amount)
          Currency::Converters.new(value: amount, from: 'BRL', to: currency)
                              .convert
                              .to_f
        end
      end
    end
  end
end
