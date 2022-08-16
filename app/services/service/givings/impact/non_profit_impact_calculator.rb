module Service
  module Givings
    module Impact
      class NonProfitImpactCalculator
        attr_reader :non_profit, :value, :currency

        def initialize(non_profit:, value:, currency:)
          @non_profit = non_profit
          @value = value
          @currency = currency
        end

        def rounded_impact
          @rounded_impact ||= impact.round
        end

        def impact
          @impact ||= non_profit.impact_by_ticket * total_tickets
        end

        private

        def total_tickets
          @total_tickets ||= amount / ticket_cost
        end

        def ticket_cost
          @ticket_cost ||= Money.from_cents(RibonConfig.default_ticket_value, :usd)
        end

        def amount
          @amount ||= Currency::Converters.convert_to_usd(value:, from: currency)
        end
      end
    end
  end
end
