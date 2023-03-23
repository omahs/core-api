# frozen_string_literal: true

module Service
  module Contributions
    class ContributionFeeCalculatorService
      attr_reader :payer_contribution_balance, :initial_contributions_balance, :fee_to_be_paid

      def initialize(payer_contribution_balance:, fee_to_be_paid:, initial_contributions_balance:)
        @payer_contribution_balance = payer_contribution_balance
        @fee_to_be_paid = fee_to_be_paid
        @initial_contributions_balance = initial_contributions_balance
      end

      def calculate_proportional_fee
        return payer_fees_balance_cents if payer_fees_balance_cents <= minimum_fee

        proportional_contribution = fee_to_be_paid * payer_relative_percentage_of_total
        return payer_fees_balance_cents if payer_fees_balance_cents <= proportional_contribution

        [proportional_contribution, minimum_fee].max&.ceil
      end

      private

      def minimum_fee
        @minimum_fee ||= RibonConfig.minimum_contribution_chargeable_fee_cents
      end

      def payer_relative_percentage_of_total
        @payer_relative_percentage_of_total ||= payer_fees_balance_cents / initial_contributions_balance.to_f
      end

      def payer_fees_balance_cents
        @payer_fees_balance_cents ||= payer_contribution_balance.fees_balance_cents
      end
    end
  end
end
