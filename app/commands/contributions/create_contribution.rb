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
        contribution.set_contribution_balance

        handle_contribution_fees(contribution)
      end
    rescue StandardError => e
      errors.add(:message, e.message)
      Reporter.log(error: e)
    end

    private

    def handle_contribution_fees(contribution)
      HandleContributionFee.call(contribution:)
    end
  end
end
