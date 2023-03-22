module Service
  module Contributions
    class ContributionFeeService
      attr_reader :contribution, :initial_contributions_balance

      # TODO: put this value in RibonConfig
      CONTRACT_FEE_PERCENTAGE = 0.2

      def initialize(contribution:)
        @contribution = contribution
        @initial_contributions_balance ||= ContributionBalance.sum(:fees_balance_cents)
      end

      def spread_fee_to_payers
        accumulated_fees_result = initial_fee_generated_by_new_contribution.ceil

        ordered_feeable_contribution_balances.each do |contribution_balance|
          if last_payer?(accumulated_fees_result:, contribution_balance:)
            charge_remaining_fee_from_last_contribution_balance(accumulated_fees_result:, contribution_balance:)

            accumulated_fees_result = 0
            break
          end

          fee_cents = calculate_fee_for(contribution_balance:)
          create_contribution_fee(contribution_balance:, fee_cents:)
          accumulated_fees_result -= fee_cents

          update_contribution_balance(contribution_balance:, fee_cents:)
        end
      end

      private

      def last_payer?(accumulated_fees_result:, contribution_balance:)
        accumulated_fees_result < minimum_fee || contribution_balance == ordered_feeable_contribution_balances.last
      end

      def minimum_fee
        RibonConfig.minimum_contribution_chargeable_fee_cents
      end

      def initial_fee_generated_by_new_contribution
        contribution.usd_value_cents * CONTRACT_FEE_PERCENTAGE
      end

      def ordered_feeable_contribution_balances
        @ordered_feeable_contribution_balances ||= ContributionBalance.all
                                                                      .where.not(contribution_id: contribution.id)
                                                                      .order(:fees_balance_cents)
      end

      def calculate_fee_for(contribution_balance:)
        return contribution_balance.fees_balance_cents if contribution_balance.fees_balance_cents <= minimum_fee

        relative_percentage_of_total = contribution_balance.fees_balance_cents / initial_contributions_balance.to_f
        proportional_contribution = initial_fee_generated_by_new_contribution * relative_percentage_of_total

        if contribution_balance.fees_balance_cents <= proportional_contribution
          return contribution_balance.fees_balance_cents
        end

        [proportional_contribution, minimum_fee].max.ceil
      end

      # TODO: Criar um command para realizar essa atualização do balanço
      def update_contribution_balance(contribution_balance:, fee_cents:)
        ::Contributions::UpdateContributionBalance.call(contribution_balance:, fee_cents:,
                                                        total_fees_increased_cents: fee_cents)
      end

      def create_contribution_fee(contribution_balance:, fee_cents:)
        ContributionFee.create!(contribution:, fee_cents:, payer_contribution: contribution_balance.contribution)
      end

      def charge_remaining_fee_from_last_contribution_balance(accumulated_fees_result:, contribution_balance:)
        fee_cents = accumulated_fees_result
        ContributionFee.create!(contribution:, fee_cents:, payer_contribution: contribution_balance.contribution)

        update_contribution_balance(contribution_balance:, fee_cents:)
      end
    end
  end
end
