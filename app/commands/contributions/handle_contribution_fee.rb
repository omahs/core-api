# frozen_string_literal: true

module Contributions
  class HandleContributionFee < ApplicationCommand
    prepend SimpleCommand

    attr_reader :contribution

    CONTRACT_FEE_PERCENTAGE = 0.2

    def initialize(contribution:)
      @contribution = contribution
    end

    def call
      spread_fee_to_payers
    end

    private


    def contributions_to_become_payers
      Contribution.all.where.not(id: contribution.id)
    end

    def spread_fee_to_payers
      contributions_to_become_payers.each do |payer_contribution|
        next unless payer_contribution.contribution_balance&.fees_balance_cents&.positive?

        fee_cents = calculate_fee_for
        ContributionFee.create!(contribution:, fee_cents:, payer_contribution:)

        update_payer_contribution_balance(payer_contribution, fee_cents)
      end
    end

    def contribution_generated_fee
      contribution.liquid_value_cents * CONTRACT_FEE_PERCENTAGE
    end

    def calculate_fee_for
      minimum_contribution_chargeable_fee_cents = RibonConfig.minimum_contribution_chargeable_fee_cents
      # TODO: change this to proportional ratio
      calculated_fee_for_payer = contribution_generated_fee / contributions_to_become_payers.count

      [calculated_fee_for_payer, minimum_contribution_chargeable_fee_cents].max
    end

    def ordered_contribution_balances
      ContributionBalance.where('fees_balance_cents > 0').where.not(contribution_id: contribution.id).order(:fee_balance_cents)
    end

    def calculate_contribution_value_without_current_contribution(:contribution_value)
      PersonPayment.sum(:amount_cents) - contribution_value.contribution.person_payment.amount_cents
    end

    def calculate_proportional_fee(:contribution_balance)
      contribution_value = contribution_balance.contribution.person_payment.amount_cents
      contribution_value / calculate_contribution_value_without_current_contribution(contribution_balance)
    end

    def update_payer_contribution_balance(payer_contribution, fee_cents)
      payer_contribution.contribution_balance.fees_balance_cents -= fee_cents
      payer_contribution.contribution_balance.total_fees_increased_cents += fee_cents
      payer_contribution.contribution_balance.save
    end

    def minimum_contribution_chargeable_fee_cents
      RibonConfig.minimum_contribution_chargeable_fee_cents
    end
  end
end
