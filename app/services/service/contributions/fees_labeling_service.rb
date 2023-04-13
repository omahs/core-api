module Service
  module Contributions
    class FeesLabelingService
      attr_reader :contribution, :initial_contributions_balance

      CONTRACT_FEE_PERCENTAGE = 0.1

      def initialize(contribution:)
        @contribution = contribution
        @initial_contributions_balance = ContributionBalance.sum(:fees_balance_cents)
      end

      def spread_fee_to_payers
        deal_with_fees_balances_empty
        accumulated_fees_result = fee_generated_by_new_contribution.ceil

        feeable_contribution_balances.each do |contribution_balance|
          if last_payer?(accumulated_fees_result:, contribution_balance:)
            charge_remaining_fee_from_last_contribution_balance(accumulated_fees_result:, contribution_balance:)
            break 0
          end

          fee_cents = calculate_fee_for(contribution_balance:)
          contribution_increased_amount_cents = calculate_increased_value_for(contribution_balance:)
          handle_fee_creation_for(contribution_balance:, fee_cents:, contribution_increased_amount_cents:)

          accumulated_fees_result -= fee_cents
        end
      end

      private

      def handle_fee_creation_for(contribution_balance:, fee_cents:, contribution_increased_amount_cents:)
        create_contribution_fee(
          contribution_balance:, fee_cents:,
          payer_contribution_increased_amount_cents: contribution_increased_amount_cents
        )
        update_contribution_balance(contribution_balance:, fee_cents:, contribution_increased_amount_cents:)
      end

      def last_payer?(accumulated_fees_result:, contribution_balance:)
        accumulated_fees_result < minimum_fee || contribution_balance == feeable_contribution_balances.last
      end

      def minimum_fee
        RibonConfig.minimum_contribution_chargeable_fee_cents
      end

      def fee_generated_by_new_contribution
        contribution.generated_fee_cents
      end

      def feeable_contribution_balances
        @feeable_contribution_balances ||= ContributionQueries.new(contribution:)
                                                              .ordered_feeable_contribution_balances
      end

      def contribution_fee_calculator_service(contribution_balance:)
        payer_balance = contribution_balance.fees_balance_cents
        fee_to_be_paid = fee_generated_by_new_contribution

        ContributionFeeCalculatorService.new(payer_balance:, fee_to_be_paid:, initial_contributions_balance:)
      end

      def calculate_fee_for(contribution_balance:)
        contribution_fee_calculator_service(contribution_balance:).proportional_fee
      end

      def calculate_increased_value_for(contribution_balance:)
        contribution_fee_calculator_service(contribution_balance:).increased_value_for(contribution:)
      end

      def update_contribution_balance(contribution_balance:, fee_cents:, contribution_increased_amount_cents:)
        ::Contributions::UpdateContributionBalance.call(contribution_balance:, fee_cents:,
                                                        contribution_increased_amount_cents:)
      end

      def create_contribution_fee(contribution_balance:, fee_cents:, payer_contribution_increased_amount_cents:)
        ContributionFee.create!(contribution:, fee_cents:, payer_contribution: contribution_balance.contribution,
                                payer_contribution_increased_amount_cents:)
      end

      def charge_remaining_fee_from_last_contribution_balance(accumulated_fees_result:, contribution_balance:)
        deal_with_remaining_fee(accumulated_fees_result:, contribution_balance:)
        fee_cents = [accumulated_fees_result, contribution_balance.fees_balance_cents].min
        payer_contribution_increased_amount_cents =
          contribution.usd_value_cents * fee_cents / contribution.generated_fee_cents.to_f

        create_contribution_fee(contribution_balance:, fee_cents:, payer_contribution_increased_amount_cents:)

        update_contribution_balance(contribution_balance:, fee_cents:,
                                    contribution_increased_amount_cents: fee_cents)
      end

      def deal_with_remaining_fee(accumulated_fees_result:, contribution_balance:)
        return if accumulated_fees_result <= contribution_balance.fees_balance_cents

        remaining_fee = accumulated_fees_result - contribution_balance.fees_balance_cents
        HandleRemainingContributionFee.new(contribution:, remaining_fee:).spread_remaining_fee
      end

      def deal_with_fees_balances_empty
        return unless feeable_contribution_balances.empty?

        HandleRemainingContributionFee
          .new(contribution:, remaining_fee: fee_generated_by_new_contribution).spread_remaining_fee
      end
    end
  end
end
