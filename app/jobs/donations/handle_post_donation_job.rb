module Donations
  class HandlePostDonationJob < ApplicationJob
    queue_as :default

    def perform(donation:)
      user = donation.user

      send_7_donations_email(user) if user.donations.count == 7
    rescue StandardError
      nil
    end

    private

    def send_7_donations_email(user)
      SendgridWebMailer.send_email(receiver: user.email, dynamic_template_data: {},
                    template_name: "user_donated_7_tickets_template_id", language: user.language).deliver_later
    end
  end
end
