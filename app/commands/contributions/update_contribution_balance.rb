# frozen_string_literal: true

module Contributions
  class UpdateContributionBalance < ApplicationCommand
    prepend SimpleCommand

    attr_reader :contribution_balance, :fee_cents, :total_fees_increased_cents

    def initialize(contribution_balance:, fee_cents:, total_fees_increased_cents:)
      @contribution_balance = contribution_balance
      @fee_cents = fee_cents
      @total_fees_increased_cents = total_fees_increased_cents
    end

    def call
      contribution_balance.total_fees_increased_cents += total_fees_increased_cents
      contribution_balance.fees_balance_cents -= fee_cents
      contribution_balance.save
    end
  end
end
