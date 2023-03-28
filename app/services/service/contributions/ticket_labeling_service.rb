module Service
  module Contributions
    class TicketLabelingService
      attr_reader :donation

      def initialize(donation:)
        @donation = donation
        @initial_tickets_balance_cents = ContributionBalance.sum(:tickets_balance_cents)
      end

      def spread_tickets_to_payers; end

      def last_contribution_payer_type
        DonationContribution.last.contribution&.person_payment&.payer_type
      end

      def contributions_by_payer_type
        if last_contribution_payer_type == 'BigDonor'
          return Contribution.joins(:contribution_balance, :person_payment)
                             .where('person_payments.payer_type IN (?, ?)', 'Customer', 'CryptoUser')
        end

        Contribution.joins(:contribution_balance, :person_payment)
                    .where(person_payments: { payer_type: 'BigDonor' })
      end

      def contributions_with_less_than_10_percent
        contributions_by_payer_type
          .where('contribution_balances.tickets_balance_cents > 0')
          .where('contribution_balances.tickets_balance_cents <= 0.1 * person_payments.crypto_value_cents')
      end

      def ordered_contributions
        contributions_by_payer_type.joins(
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
