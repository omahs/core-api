module Donations
  class UpdatePoolBalanceWorker
    include Sidekiq::Worker
    sidekiq_options queue: :donations

    def perform(*_args)
      Pool.all.each do |pool|
        Donations::UpdatePoolBalanceJob.perform_later(pool:)
      end
    rescue StandardError => e
      Reporter.log(error: e, extra: { message: e.message })
    end
  end
end
