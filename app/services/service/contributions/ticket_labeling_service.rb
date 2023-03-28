module Service
  module Contributions
    class TicketLabelingService
      attr_reader :donation

      def initialize(donation:)
        @donation = donation
      end

      def label_donation
        contribution_to_label = next_contribution_to_label_ticket

        DonationContribution.create!(contribution: next_contribution_to_label_ticket, donation:)
        update_contribution_balance(contribution_balance: contribution_to_label.contribution_balance)

        contribution_to_label
      rescue StandardError => e
        Reporter.log(error: e)
      end

      private

      def update_contribution_balance(contribution_balance:)
        contribution_balance.tickets_balance_cents -= donation.value
        contribution_balance.save!
      end

      def next_contribution_to_label_ticket
        return contributions_with_less_than_10_percent.last if contributions_with_less_than_10_percent.any?

        ordered_contributions.to_a.last
      end

      def last_contribution_payer_type
        DonationContribution.last_contribution_payer_type
      end

      def base_contributions
        Contribution.joins(:contribution_balance)
                    .where('contribution_balances.tickets_balance_cents >= ?', donation.value)
                    .where(receiver: donation.cause)
      end

      def contributions_by_payer_type
        if last_contribution_payer_type == 'BigDonor'
          promoter_contributions = base_contributions.from_promoters

          return promoter_contributions if promoter_contributions.any?
        end

        base_contributions.from_big_donors
      end

      def contributions_with_less_than_10_percent
        contributions_by_payer_type
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
