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

    def calculate_fee
      contribution.liquid_value_cents * CONTRACT_FEE_PERCENTAGE
    end

    def spread_fee_to_payers
      Contribution.all.each do |payer_contribution|
        fee_cents = calculate_fee / Contribution.all.count
        ContributionFee.create!(contribution:, fee_cents:, payer_contribution:)
        next unless payer_contribution.contribution_balance

        payer_contribution.contribution_balance.fees_balance_cents -= fee_cents
        payer_contribution.contribution_balance.total_fees_increased_cents += fee_cents
        payer_contribution.contribution_balance.save
      end
    end
  end
end
