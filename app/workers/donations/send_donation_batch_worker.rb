module Donations
  class SendDonationBatchWorker
    include Sidekiq::Worker
    sidekiq_options queue: :donations

    def perform
      Integration.all.each do |integration|
        NonProfit.all.each do |non_profit|
          result = Donations::CreateDonationsBatch.call(integration:, non_profit:)
          return unless result && result.batch.present?
          batch = result.batch
          CreateBatchBlockchainDonationJob.perform_later(non_profit:, integration:, batch:)
        end
      end
    rescue StandardError => e
      Reporter.log(e, { message: e.message })
    end
  end
end
