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
        contribution.liquid_value_cents * CONTRACT_FEE_PERCENTAGE
      end

      def define_payers_for_new_generated_fee
        contributions_to_become_payers
      end

      def spread_fee_to_payers(fee)
        feeable_contributions_without_minimum_contributions = feeable_contributions - contributions_with_minimum_fee
        acumulated_fees_result = fee

        feeable_contributions_without_minimum_contributions.each do |contribution|
          # TODO: isso pode gerar uma leve perda de etiquetagem (menor que o valor mínimo) para cada contribuição realizada
          break if acumulated_fees_result < MINIMUM_FEE

          fee_cents = calculate_fee_for(contribution_balance: contribution.contribution_balance)

          ContributionFee.create!(contribution: contribution, fee_cents: fee_cents, payer_contribution: contribution)
          acumulated_fees_result -= fee_cents

          update_contribution_balance(contribution, fee_cents)
        end
      end

      private

      def feeable_contributions
        @feeable_contributions ||= ContributionBalance.all.where.not(contribution_id: contribution.id)
      end

      def contributions_with_minimum_fee
        feeable_contributions.where('fees_balance_cents <= ?', MINIMUM_FEE)
      end

      def set_minimum_fee_for_selected_payers(feeable_contributions)
        payers.each do |payer|
          [payer.contribution_balance, MINIMUM_FEE].max
        end
      end

      def ordered_contribution_balances
        ContributionBalance.order(:fee_balance_cents)
      end

      def initial_contributions_balance
        ContributionBalance.sum(:fees_balance_cents)
      end

      def initial_contributions_balance
        ContributionBalance.sum(:fees_balance_cents)
      end

      # TODO: Ainda falta calcular o valor proporcional removendo os casos de fee mínimo e menores que fee mínimo
      def calculate_fee_for(contribution_balance:, remaining_fee:)
        if contribution_balance.fees_balance_cents <= MINIMUM_FEE return contribution_balance.fees_balance_cents

        proportional_contribution = remaining_fee * contribution_balance.fees_balance_cents / initial_contributions_balance

        [proportional_contribution, MINIMUM_FEE].max
      end

      # TODO: Criar um command para realizar essa atualização do balanço
      def update_contribution_balance(contribution, fee)
        contribution.contribution_balance.total_fees_increased_cents += fee
      end
    end
  end
end
