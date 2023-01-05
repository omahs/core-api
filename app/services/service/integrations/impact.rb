module Service
  module Integrations
    class Impact
      attr_reader :integration, :start_date, :end_date

      def initialize(integration:, start_date:, end_date:)
        @integration = integration
        @start_date = start_date
        @end_date = end_date
      end

      delegate :total_donations, :total_donors, :impact_per_non_profit, :donations_per_non_profit,
               :donors_per_non_profit, :donations_in_date_intervals, :donors_in_date_intervals,
               to: :statistics_service

      def formatted_impact
        { total_donations:, total_donors:, impact_per_non_profit:, donations_per_non_profit:,
          donors_per_non_profit:, donations_in_date_intervals:, donors_in_date_intervals: }
      end

      private

      def statistics_service
        @statistics_service ||= Service::Donations::Statistics.new(donations: filtered_donations)
      end

      def filtered_donations
        @filtered_donations ||= integration.donations.created_between(start_date, end_date)
      end
    end
  end
end
