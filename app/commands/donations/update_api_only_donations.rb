# frozen_string_literal: true

module Donations
  class UpdateApiOnlyDonations < ApplicationCommand
    prepend SimpleCommand

    def call
      donations_without_blockchain_transaction.each do |donation|
        CreateBlockchainDonation.call(donation:)
      end
    end

    private

    def donations_without_blockchain_transaction
      donation_query = %(LEFT OUTER JOIN donation_blockchain_transactions
                         ON donation_blockchain_transactions.donation_id = donations.id)

      @donations_without_blockchain_transaction ||= Donation
                                                    .joins(donation_query)
                                                    .where(donation_blockchain_transactions: { id: nil })
    end
  end
end
