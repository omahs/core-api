module Donations
  class SendDonationBatchWorker
    include Sidekiq::Worker
    sidekiq_options queue: :donations

    def perform
      Integration.each do |integration|
        NonProfit.each do |non_profit|
          Donations::CreateDonationsBatch.call(integeration, non_profit)
          CreateBlockchainDonationJob.perform_later(donation)
        end
      end
    rescue StandardError => e
      Reporter.log(e, { message: e.message })
    end
  end
end
