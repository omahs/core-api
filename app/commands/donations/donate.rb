# frozen_string_literal: true

module Donations
  class Donate
    prepend SimpleCommand
    attr_reader :non_profit, :integration

    def initialize(integration:, non_profit:)
      @integration = integration
      @non_profit = non_profit
    end

    def call
      create_donation
      create_blockchain_donation
      update_donation_blockchain_link
    rescue StandardError => e
      errors.add(:message, e.message)
    end

    private

    def create_donation
      Donation.create!(
        integration: integration,
        non_profit: non_profit
      )
    end

    def create_blockchain_donation
      # call contract method
    end

    def update_donation_blockchain_link
      # update donation blockchain link with the blokchain process url
    end
  end
end
