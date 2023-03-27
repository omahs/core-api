# frozen_string_literal: true

module Contributions
  class CreateContribution < ApplicationCommand
    prepend SimpleCommand
    attr_reader :payment

    def initialize(payment:)
      @payment = payment
    end

    def call
      ActiveRecord::Base.transaction do
        contribution = Contribution.create!(person_payment: payment, receiver: payment.receiver)
        handle_contribution_fees(contribution)
        contribution.set_contribution_balance
      end
    rescue StandardError => e
      errors.add(:message, e.message)
      Reporter.log(error: e)
    end

    private

    def handle_contribution_fees(contribution)
      Service::Contributions::ContributionFeeService.new(contribution:).spread_fee_to_payers
    end
  end
end
