# frozen_string_literal: true

module Donations
  class UpdateProcessingDonations < ApplicationCommand
    prepend SimpleCommand

    def call
      DonationBlockchainTransaction.processing.find_each do |donation_blockchain_transaction|
        Service::Donations::DonationBlockchainTransaction.new(donation_blockchain_transaction:).update_status
      end
    end
  end
end
