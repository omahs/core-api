module Mailers
  class SendBimonthlyEmailReportWorker
    include Sidekiq::Worker
    sidekiq_options queue: :donations

    def perform(*_args)
      User.find_in_batches(batch_size: 2_000) do |batch|
        batch.each do |user|
          if user&.last_donation_at&.between?(3.months.ago, 2.months.ago)
            Mailers::HandleBimonthlyEmailReportJob.perform_later(user:)
          end
        end
      end
    rescue StandardError => e
      Reporter.log(error: e, extra: { message: e.message })
    end
  end
end
