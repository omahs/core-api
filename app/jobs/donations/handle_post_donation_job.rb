module Donations
  class HandlePostDonationJob < ApplicationJob
    queue_as :default

    def perform(donation:)
      Mailers::SendDonationEmailJob.perform_later(donation:)
    rescue StandardError
      nil
    end
  end
end