module Donations
  class CreateBatchBlockchainDonationJob < ApplicationJob
    queue_as :donations

    def perform(non_profit:, integration:, batch:)
      CreateBatchBlockchainDonation.call(non_profit:, integration:, batch:)
    end
  end
end
