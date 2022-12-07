module Service
  module Impact
    class Statistics
      attr_reader :donations

      def initialize(donations:)
        @donations = donations
      end

      def total_donations
        @total_donations ||= donations.count
      end

      def total_donors
        @total_donors ||= donations.select(:user_id).distinct.count
      end
    end
  end
end
