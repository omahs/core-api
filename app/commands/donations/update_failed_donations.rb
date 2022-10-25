# frozen_string_literal: true

module Donations
  class UpdateFailedDonations < ApplicationCommand
    prepend SimpleCommand

    def call
      DonationBlockchainTransaction.failed.find_each do |donation_blockchain_transaction|
        CreateBlockchainDonation.call(donation: donation_blockchain_transaction.donation)
      end
    end
  end
end
