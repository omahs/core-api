module Service
  module Contributions
    class TicketLabelingService
      attr_reader :donation

      def initialize(donation:)
        @donation = donation
        @initial_tickets_balance_cents = ContributionBalance.sum(:tickets_balance_cents)
      end

      def spread_tickets_to_payers; end

      private

      def calculate_proportional_tickets_distribution; end

      def last_contribution_payer_type
        DonationContribution.last.contribution&.person_payment&.payer_type
      end

      def next_to_pay
        ordered_contributions.last
      end

      def contributions_by_payer_type
        ordered_contributions
          .group_by { |contribution| contribution.person_payment.payer_type }
      end

      def ordered_contributions
        Contribution.joins(
          "LEFT OUTER JOIN (
            SELECT MAX(created_at) AS last_donation_created_at, contribution_id
            FROM donation_contributions
            GROUP BY contribution_id
          ) AS last_donations ON contributions.id = last_donations.contribution_id"
        ).order('last_donations.last_donation_created_at DESC NULLS LAST')
      end
    end
  end
end
