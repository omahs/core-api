module Donations
  class SendDonationBatchWorker
    include Sidekiq::Worker
    sidekiq_options queue: :donations

    def perform
      Donations::CreateDonationsBatch.call
    rescue StandardError => e
      Reporter.log(e, { message: e.message })
    end
  end
end
