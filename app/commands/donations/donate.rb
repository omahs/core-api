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
      user_address = '0x6E060041D62fDd76cF27c582f62983b864878E8F'

      response = Web3::RibonContract
                 .donate_through_integration(non_profit: non_profit.wallet_address,
                                             amount: amount,
                                             user: user_address)

      body = JSON.parse(response['body'])
      body['transactionHash']
    end

    def update_donation_blockchain_link(transaction_hash)
      # TODO: update these static url
      donation.blockchain_process_link = "https://mumbai.polygonscan.com/tx/#{transaction_hash}"
      donation.save
    end
  end
end
