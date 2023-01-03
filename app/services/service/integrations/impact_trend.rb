module Service
  module Integrations
    class ImpactTrend
      attr_reader :integration, :start_date, :end_date

      def initialize(integration:, start_date:, end_date:)
        @integration = integration
        @start_date = start_date
        @end_date = end_date
      end

      def formatted_impact
        {
          total_donations: impact_service.total_donations, total_donors: impact_service.total_donors,
          impact_per_non_profit: impact_service.impact_per_non_profit,
          previous_total_donations: previous_impact_service.total_donations,
          previous_total_donors: previous_impact_service.total_donors,
          previous_impact_per_non_profit: previous_impact_service.impact_per_non_profit,
          total_donations_balance:, total_donors_balance:, total_donations_trend:, total_donors_trend:
        }
      end

      private

      def total_donations_trend
        ((total_donations_balance.to_f / previous_impact_service.total_donations) * 100).round(2)
      end

      def total_donors_trend
        ((total_donors_balance.to_f / previous_impact_service.total_donors) * 100).round(2)
      end

      def total_donations_balance
        impact_service.total_donations - previous_impact_service.total_donations
      end

      def total_donors_balance
        impact_service.total_donors - previous_impact_service.total_donors
      end

      def impact_service
        @impact_service ||= Impact.new(integration:, start_date:, end_date:)
      end

      def previous_impact_service
        @previous_impact_service ||= Impact.new(integration:, start_date: previous_start_date,
                                                end_date: previous_end_date)
      end

      def previous_start_date
        start_date - 1.month
      end

      def previous_end_date
        end_date - 1.month
      end
    end
  end
end