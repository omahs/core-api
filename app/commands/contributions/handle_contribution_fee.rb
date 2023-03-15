# frozen_string_literal: true

module Contributions
  class HandleContributionFee < ApplicationCommand
    prepend SimpleCommand

    attr_reader :contribution

    CONTRACT_FEE_PERCENTAGE = 0.3

    def initialize(contribution:)
      @contribution = contribution
    end

    def call
      spread_fee_to_payers
    end

    private

    def contribution_generated_fee
      contribution.liquid_value_cents * CONTRACT_FEE_PERCENTAGE
    end

    def spread_fee_to_payers
      contributions_to_become_payers.each do |payer_contribution|
        next unless payer_contribution.contribution_balance&.fees_balance_cents&.positive?

        fee_cents = calculate_fee_for(payer_contribution)
        ContributionFee.create!(contribution:, fee_cents:, payer_contribution:)

        update_payer_contribution_balance(payer_contribution, fee_cents)
      end
    end

    def contributions_to_become_payers
      Contribution.all.where.not(id: contribution.id)
    end

    def calculate_fee_for(_payer_contribution)
      contribution_generated_fee / contributions_to_become_payers.count
    end

    def update_payer_contribution_balance(payer_contribution, fee_cents)
      payer_contribution.contribution_balance.fees_balance_cents -= fee_cents
      payer_contribution.contribution_balance.total_fees_increased_cents += fee_cents
      payer_contribution.contribution_balance.save
    end
  end
end
