# frozen_string_literal: true

module Donations
  class UpdateFailedDonations < ApplicationCommand
    prepend SimpleCommand

    def call
      DonationBlockchainTransaction.failed.find_each do |donation_blockchain_transaction|
        update_transaction(donation_blockchain_transaction.donation)
      end
    end

    private

    def update_transaction(donation)
      CreateBlockchainDonation.call(donation:)
    rescue StandardError => e
      Reporter.log(error: e)
    end
  end
end
