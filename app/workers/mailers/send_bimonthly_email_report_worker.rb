module Mailers
  class SendBimonthlyEmailReportWorker
    include Sidekiq::Worker
    sidekiq_options queue: :donations

    def perform(*_args)
      users = User.all
      users.find_in_batches(batch_size: 2_000) do |batch|
        if user.last_donation_at.between?(3.months.ago, 2.months.ago)
          Mailers::SendFreeBimonthlyEmailReport.perform_later(donation:)
      end
    rescue StandardError => e
      Reporter.log(error: e, extra: { message: e.message })
    end
  end
end
