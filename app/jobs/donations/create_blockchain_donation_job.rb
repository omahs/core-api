module Donations
  class CreateBlockchainDonationJob < ApplicationJob
    queue_as :default

    def perform(donation)
      CreateBlockchainDonation.call(donation:)
    end
  end
end
