module Service
  module Contributions
    class ContributionFeeService
      attr_reader :contribution

      CONTRACT_FEE_PERCENTAGE = 0.2
      MINIMUM_FEE = RibonConfig.minimum_contribution_chargeable_fee_cents

      def initialize(contribution:)
        @contribution = contribution
      end

      def initial_fee_generated_by_new_contribution
        contribution.usd_value_cents * CONTRACT_FEE_PERCENTAGE
      end

      def define_payers_for_new_generated_fee
        contributions_to_become_payers
      end

      def spread_fee_to_payers
        accumulated_fees_result = initial_fee_generated_by_new_contribution.round

        ordered_feeable_contribution_balances.each do |contribution_balance|
          if accumulated_fees_result < MINIMUM_FEE
            fee_cents = accumulated_fees_result
            ContributionFee.create!(contribution:, fee_cents:, payer_contribution: contribution_balance.contribution)
            accumulated_fees_result -= accumulated_fees_result
            update_contribution_balance(contribution_balance:, fee_cents:)
            break
          end

          fee_cents = calculate_fee_for(contribution_balance:, remaining_fee: accumulated_fees_result)
          ContributionFee.create!(contribution:, fee_cents:, payer_contribution: contribution_balance.contribution)
          accumulated_fees_result -= fee_cents
          update_contribution_balance(contribution_balance:, fee_cents:)
        end
      end

      private

      def ordered_feeable_contribution_balances
        @ordered_feeable_contribution_balances ||= ContributionBalance.all.
                                                   where.not(contribution_id: contribution.id)
                                                                      .order(:fees_balance_cents)
      end

      def initial_contributions_balance
        @initial_contributions_balance ||= ContributionBalance.sum(:fees_balance_cents)
      end

      def calculate_fee_for(contribution_balance:, remaining_fee:)
        return contribution_balance.fees_balance_cents if contribution_balance.fees_balance_cents <= MINIMUM_FEE

        relative_percentage_of_total = contribution_balance.fees_balance_cents / initial_contributions_balance
        proportional_contribution = remaining_fee * relative_percentage_of_total
        if contribution_balance.fees_balance_cents <= proportional_contribution
          return contribution_balance.fees_balance_cents
        end

        [proportional_contribution, MINIMUM_FEE].max
      end

      # TODO: Criar um command para realizar essa atualização do balanço
      def update_contribution_balance(contribution_balance:, fee_cents:)
        contribution_balance.total_fees_increased_cents += fee_cents # TODO: calcular de forma certa
        contribution_balance.fees_balance_cents -= fee_cents
        contribution_balance.save
      end
    end
  end
end
