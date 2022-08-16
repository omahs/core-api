# frozen_string_literal: true

module Givings
  module Impact
    class CalculateImpactToNonProfit < ApplicationCommand
      prepend SimpleCommand

      attr_reader :non_profit, :value, :currency

      def initialize(non_profit:, value:, currency:)
        @non_profit = non_profit
        @value = value
        @currency = currency
      end

      def call
        with_exception_handle do
          { impact: impact_service.impact, rounded_impact: impact_service.rounded_impact }
        end
      end

      private

      def impact_service
        @impact_service ||= Service::Givings::Impact::NonProfitImpactCalculator.new(value:, non_profit:, currency:)
      end
    end
  end
end
