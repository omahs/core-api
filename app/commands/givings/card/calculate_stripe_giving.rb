# frozen_string_literal: true

module Givings
  module Card
    class CalculateStripeGiving < ApplicationCommand
      prepend SimpleCommand
      attr_reader :currency, :value

      def initialize(value:, currency:)
        @value = value
        @currency = currency
      end

      def call
        card_fee = stripe_fee_calculator.calculate_fee
        crypto_fee = crypto_fee_calculator.calculate_fee
        service_fees = card_fee + crypto_fee
        net_giving = money_value - service_fees
        crypto_giving = converted_giving(net_giving) - service_fees

        {
          giving_total: money_value.format, net_giving: net_giving.format,
          crypto_giving: crypto_giving.format, card_fee: card_fee.format,
          crypto_fee: crypto_fee.format, service_fees: service_fees.format
        }
      end

      private

      def stripe_fee_calculator
        GivingServices::Fees::Card::StripeCardFeeCalculatorService.new(value: value, currency: currency)
      end

      def crypto_fee_calculator
        GivingServices::Fees::Crypto::PolygonFeeCalculatorService.new(value: value, currency: currency)
      end

      def money_value
        @money_value ||= Money.from_amount(value, currency)
      end

      def converted_giving(net_giving)
        return money_value if currency == :usd

        Currency::Converters
          .convert(value: net_giving.amount, from: net_giving.currency.to_sym.downcase, to: :usd)
      end
    end
  end
end
