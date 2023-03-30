module Service
  module Contributions
    class LabelDonationsByCauseService
      attr_reader :cause

      def initialize(cause:)
        @cause = cause
      end

      def label_donation_by_cause
        big_donors_donations_array, unique_donors_donations_array = separate_donations_between_big_donors_and_unique_donors

        base_contributions.each do |contribution|

          if contribution.from_big_donor?
            total_donations_from_big_donors = big_donors_donations_array.size

            donation_percentage_from_total = contribution.contribution_balance.tickets_balance_cents / total_tickets_balance_from_big_donors

            donations_to_label = total_donations_from_big_donors * donation_percentage_from_total

            donations_array_after_current_label = big_donors_donations_array.shift(donations_to_label)

            donations_array_after_current_label.each do |donation|
              create_donation_contribution(contribution:, donation:)
              update_contribution_balance(contribution_balance: contribution.contribution_balance)
            end
          else
            total_donations_from_unique_donors = unique_donors_donations_array.size

            donation_percentage_from_total = contribution.contribution_balance.tickets_balance_cents / total_tickets_balance_from_unique_donors

            donations_to_label = total_donations_from_unique_donors * donation_percentage_from_total

            donations_array_after_current_label = unique_donors_donations_array.shift(donations_to_label)

            donations_array_after_current_label.each do |donation|
              create_donation_contribution(contribution:, donation:)
              update_contribution_balance(contribution_balance: contribution.contribution_balance)
            end
          end
        end

      rescue StandardError => e
        Reporter.log(error: e)
      end

      private

      def total_tickets_balance_from_big_donors
        ContributionBalance.total_tickets_balance_from_big_donors
      end

      def total_tickets_balance_from_unique_donors
        ContributionBalance.total_tickets_balance_from_unique_donors
      end

      def donations_without_donation_contribution
        Donation.left_outer_joins(:donation_contribution).where(donation_contributions: { id: nil }).for_cause(cause.id)
      end

      def total_donations_without_donation_contribution_by_cause
        donations_without_donation_contribution.count
      end

      def separate_donations_between_big_donors_and_unique_donors
        donations_without_donation_contribution.each_slice( (donations_without_donation_contribution.size/2.0).round ).to_a
      end

      def base_contributions
        Contribution
          .with_tickets_balance_higher_than(0)
          .where(receiver: cause)
      end
    end
  end
end
