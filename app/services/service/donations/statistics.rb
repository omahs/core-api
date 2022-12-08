module Service
  module Donations
    class Statistics
      attr_reader :donations

      def initialize(donations:)
        @donations = donations
      end

      def total_donations
        @total_donations ||= donations.count
      end

      def total_donors
        @total_donors ||= donations.distinct.count(:user_id)
      end

      def impact_per_non_profit
        non_profits.map { |non_profit| format_result(non_profit) }
      end

      private

      def format_result(non_profit)
        { non_profit:, impact: impact_sum_by_non_profit(non_profit) }
      end

      def impact_sum_by_non_profit(non_profit)
        usd_to_impact_factor = non_profit.impact_for.usd_cents_to_one_impact_unit

        (total_usd_cents_donated_for(non_profit) / usd_to_impact_factor).to_i
      end

      def total_usd_cents_donated_for(non_profit)
        donations.where(non_profit:).sum(&:value)
      end

      def non_profits
        NonProfit.all
      end
    end
  end
end
