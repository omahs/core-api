# frozen_string_literal: true

module Givings
  module Card
    class CalculateCardGiving < ApplicationCommand
      prepend SimpleCommand
      include GivingServices::Fees::Crypto

      attr_reader :currency, :value, :gateway

      def initialize(value:, currency:, gateway: default_gateway)
        @value = value
        @currency = currency
        @gateway = gateway
      end

      def call
        with_exception_handle do
          net_giving = money_value - service_fees
          crypto_giving = converted_giving(net_giving) - service_fees

          formatted_result(net_giving, crypto_giving)
        end
      end

      private

      def formatted_result(net_giving, crypto_giving)
        {
          giving_total: money_value.format, net_giving: net_giving.format,
          crypto_giving: crypto_giving.format, card_fee: card_fee.format,
          crypto_fee: crypto_fee.format, service_fees: service_fees.format
        }
      end

      def card_fee
        card_fee_calculator.calculate_fee
      end

      def crypto_fee
        crypto_fee_calculator.calculate_fee
      end

      def service_fees
        card_fee + crypto_fee
      end

      def card_fee_calculator
        fee_class.new(value:, currency:)
      end

      def crypto_fee_calculator
        PolygonFeeCalculatorService.new(value:, currency:)
      end

      def money_value
        @money_value ||= Money.from_amount(value, currency)
      end

      def converted_giving(net_giving)
        return money_value if currency == :usd

        Currency::Converters
          .convert(value: net_giving.amount, from: net_giving.currency.to_sym.downcase, to: :usd)
      end

      def fee_class
        "GivingServices::Fees::Card::#{gateway.to_s.capitalize}CardFeeCalculatorService".constantize
      end

      def default_gateway
        :stripe
      end
    end
  end
end
