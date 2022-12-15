module Donations
  class SendDonationBatchJob < ApplicationJob
    def perform(_arg1, _arg2)
      Integration.all.each do |integration|
        NonProfit.all.each do |non_profit|
          batch = Donations::CreateDonationsBatch.call(integration, non_profit).result
          CreateBatchBlockchainDonationJob.perform_later(non_profit, integration, batch) if batch
        end
      end
    rescue StandardError => e
      Reporter.log(e, { message: e.message })
    end
  end
end
