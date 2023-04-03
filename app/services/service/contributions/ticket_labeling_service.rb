module Service
  module Contributions
    class TicketLabelingService
      attr_reader :donation

      def initialize(donation:)
        @donation = donation
      end

      def label_donation
        payer_contribution = next_contribution_to_label_the_donation

        create_donation_contribution(contribution: payer_contribution)
        update_contribution_balance(contribution_balance: payer_contribution.contribution_balance)

        payer_contribution
      rescue StandardError => e
        Reporter.log(error: e)
      end

      private

      def create_donation_contribution(contribution:)
        DonationContribution.create!(contribution:, donation:)
      end

      def update_contribution_balance(contribution_balance:)
        contribution_balance.tickets_balance_cents -= donation.value
        contribution_balance.save!
      end

      def next_contribution_to_label_the_donation
        if contributions_with_balance_smaller_than_10_percent.any?
          return contributions_with_balance_smaller_than_10_percent.last
        end

        contributions_ordered_by_label_date.to_a.last
      end

      def last_contribution_payer_type
        DonationContribution.last_contribution_payer_type
      end

      def base_contributions
        Contribution
          .with_tickets_balance_higher_than(donation.value)
          .where(receiver: donation.cause)
      end

      def contributions_by_payer_type
        if last_contribution_payer_type == 'BigDonor'
          promoter_contributions = base_contributions.from_unique_donors

          return promoter_contributions if promoter_contributions.any?
        end

        base_contributions.from_big_donors
      end

      def contributions_with_balance_smaller_than_10_percent
        contributions_by_payer_type
          .where('contribution_balances.tickets_balance_cents <= 0.1 * person_payments.crypto_value_cents')
      end

      def contributions_ordered_by_label_date
        contributions_by_payer_type.ordered_by_donation_contribution
      end

      def donations_without_donation_contribution
        Donation.left_outer_joins(:donation_contribution).where(donation_contributions: { id: nil })
      end

      def total_donation_contributions
        donations_without_donation_contribution.count
      end

      def group_donation_contributions_by_cause
        donations_without_donation_contribution.group_by { |donation| donation.cause.name }
      end

      def method_name

      end
    end
  end
end
