module Donations
  class SendDonationBatchWorker
    include Sidekiq::Worker
    sidekiq_options queue: :donations

    def perform
      Integration.each do |integration|
        NonProfit.each do |non_profit|
          batch = Donations::CreateDonationsBatch.call(integration:, non_profit:)
          CreateBatchBlockchainDonationJob.perform_later(non_profit:, integration:, batch:)
        end
      end
    rescue StandardError => e
      Reporter.log(e, { message: e.message })
    end
  end
end
