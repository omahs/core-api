module Donations
  class CreateBatchBlockchainDonationJob < ApplicationJob
    queue_as :default
    sidekiq_options retry: 3

    def perform(non_profit:, integration:, batch:)
      CreateBatchBlockchainDonation.call(non_profit:, integration:, batch:)
    end

    sidekiq_retry_in do |count|
      12.hours.to_i * (count + 1) # (i.e. 12 h, 24h, 36h)
    end
  end
end