module Contributions
  class TicketsLabelerWorker
    include Sidekiq::Worker
    sidekiq_options queue: :donations

    def perform(*_args)
      donations_without_donation_contribution.each do |donation|
        donation
      end
    rescue StandardError => e
      Reporter.log(error: e, extra: { message: e.message })
    end

    private

    def donations_without_donation_contribution
      Donation.left_outer_joins(:donation_contribution).where(donation_contributions: { id: nil })
    end

    def total_donation_contributions
      donations_without_donation_contribution.count
    end
  end
end
