module Mailers
  class SendOneWeekInactivityEmailWorker
    include Sidekiq::Worker
    sidekiq_options queue: :mailers, retry: 3

    def perform(*_args)
      SendOneWeekInactivityEmailJob.perform_later
    rescue StandardError => e
      Reporter.log(error: e, extra: { message: e.message })
    end
  end
end
