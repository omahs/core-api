# frozen_string_literal: true

module Donations
  class Donate
    prepend SimpleCommand
    attr_reader :non_profit, :integration, :donation, :user

    DEFAULT_DONATION_AMOUNT = 1_000_000_000_000_000

    def initialize(integration:, non_profit:, user:)
      @integration = integration
      @non_profit = non_profit
      @user = user
    end

    def call
      create_donation
      transaction_hash = create_blockchain_donation
      update_donation_blockchain_link(transaction_hash)

      transaction_hash
    rescue StandardError => e
      errors.add(:message, e.message)
    end

    private

    def create_donation
      @donation = Donation.create!(
        integration: integration,
        non_profit: non_profit,
        user: user
      )
    end

    def create_blockchain_donation
      # TODO: update those static values
      amount = DEFAULT_DONATION_AMOUNT

      response = Web3::RibonContract.donate_through_integration(
        non_profit_address: non_profit.wallet_address,
        amount: amount,
        user_email: user.email
      )

      body = JSON.parse(response['body'])
      body['transactionHash']
    end

    def update_donation_blockchain_link(transaction_hash)
      donation.blockchain_process_link = "#{RibonCoreApi.config[:blockchain][:scan_url]}#{transaction_hash}"
      donation.save
    end
  end
end
