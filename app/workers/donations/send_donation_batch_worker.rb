module Donations
  class SendDonationBatchWorker
    include Sidekiq::Worker
    sidekiq_options queue: :donations

    def perform
      Integration.all.each do |integration|
        NonProfit.all.each do |non_profit|
          batch = Donations::CreateDonationsBatch.call(integration:, non_profit:).result
          CreateBatchBlockchainDonationJob.perform_later(non_profit:, integration:, batch:) if batch
        end
      end
    rescue StandardError => e
      Reporter.log(error: e,extra: { message: e.message })
    end
  end
end
