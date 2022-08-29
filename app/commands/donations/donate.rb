# frozen_string_literal: true

module Donations
  class Donate < ApplicationCommand
    prepend SimpleCommand
    attr_reader :non_profit, :integration, :donation, :user, :transaction_hash

    CENTS_FACTOR = 0.01

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
      Donation.transaction do
        create_donation
        @transaction_hash = create_blockchain_donation
        set_user_last_donation_at
        create_donation_blockchain_transaction(transaction_hash)
      end

      transaction_hash
    end

    def allowed?
      user.can_donate?(integration)
    end

    def create_donation
      @donation = Donation.create!(integration:, non_profit:, user:, value: ticket_value)
    end

    def create_blockchain_donation
      amount = ticket_value * CENTS_FACTOR
      non_profit_wallet_address = non_profit.wallet_address

      ribon_contract.donate_through_integration(donation_pool_address:,
                                                non_profit_wallet_address:,
                                                user: user.email, amount:, sender_key:)
    end

    def create_donation_blockchain_transaction(transaction_hash)
      donation.create_donation_blockchain_transaction(transaction_hash:, chain:)
    end

    def set_user_last_donation_at
      SetUserLastDonationAt.call(user:, date_to_set: donation.created_at)
    end

    def sender_key
      @sender_key ||= integration.integration_wallet&.private_key
    end

    def ticket_value
      @ticket_value ||= RibonConfig.default_ticket_value
    end

    def ribon_contract
      @ribon_contract ||= Web3::Contracts::RibonContract.new(chain:)
    end

    def chain
      @chain ||= Chain.default
    end

    def donation_pool_address
      '0x174C30d9D70d0f18b18736e4a1ddbba9EF9D0330'
    end
  end
end
