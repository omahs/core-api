module Service
  module Contributions
    class TicketLabelingService
      attr_reader :donation

      def initialize(donation:)
        @donation = donation
      end

      def spread_tickets_to_payers; end
    end
  end
end
