module Service
  module Integrations
    class Impact
      attr_reader :integration, :start_date, :end_date

      def initialize(integration:, start_date:, end_date:)
        @integration = integration
        @start_date = start_date
        @end_date = end_date
      end

      def total_donations
        @total_donations ||= statistics_service.total_donations
      end

      def total_donors
        @total_donors ||= statistics_service.total_donors
      end

      private

      def statistics_service
        @statistics_service ||= Service::Impact::Statistics.new(donations: filtered_donations)
      end

      def filtered_donations
        @filtered_donations ||= integration.donations.created_between(start_date, end_date)
      end
    end
  end
end
