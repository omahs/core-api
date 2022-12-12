# frozen_string_literal: true

module Donations
  class Donate < ApplicationCommand
    prepend SimpleCommand
    attr_reader :non_profit, :integration, :donation, :user

    def initialize(integration:, non_profit:, user:)
      @integration = integration
      @non_profit = non_profit
      @user = user
    end

    def call
      with_exception_handle do
        if allowed?
          transact_donation
        else
          errors.add(:message, I18n.t('donations.blocked_message'))
        end
      end
    end

    private

    def transact_donation
      create_donation
      # create_blockchain_donation
      set_user_last_donation_at
      set_last_donated_cause

      donation
    end

    def allowed?
      user.can_donate?(integration)
    end

    def create_donation
      @donation = Donation.create!(integration:, non_profit:, user:, value: ticket_value)
    end

    def create_blockchain_donation
      CreateBlockchainDonationJob.perform_later(donation)
    end

    def set_user_last_donation_at
      SetUserLastDonationAt.call(user:, date_to_set: donation.created_at)
    end

    def set_last_donated_cause
      SetLastDonatedCause.call(user:, cause: non_profit.cause)
    end

    def ticket_value
      @ticket_value ||= RibonConfig.default_ticket_value
    end
  end
end
