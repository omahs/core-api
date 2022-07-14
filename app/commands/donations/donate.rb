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
        Donation.transaction do
          create_donation
          @transaction_hash = create_blockchain_donation
          set_user_last_donation_at
          update_donation_blockchain_link(transaction_hash)
        end

        transaction_hash
      end
    end

    private

    def create_donation
      @donation = Donation.create!(integration:, non_profit:, user:, value: ticket_value)
    end

    def create_blockchain_donation
      amount = ticket_value * CENTS_FACTOR
      non_profit_wallet_address = non_profit.wallet_address

      ribon_contract.donate_through_integration(non_profit_wallet_address:, user: user.email, amount:)
    end

    def update_donation_blockchain_link(transaction_hash)
      donation.blockchain_process_link = "#{network[:block_explorer_url]}/tx/#{transaction_hash}"
      donation.save
    end

    def set_user_last_donation_at
      SetUserLastDonationAt.call(user:, date_to_set: donation.created_at)
    end

    def ticket_value
      @ticket_value ||= RibonConfig.default_ticket_value
    end

    def ribon_contract
      @ribon_contract ||= Web3::Contracts::RibonContract.new(network:)
    end

    def network
      @network ||= Web3::Providers::Networks::MUMBAI
    end
  end
end
