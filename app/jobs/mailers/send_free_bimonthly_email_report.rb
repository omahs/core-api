module Mailers
  class SendFreeBimonthlyEmailReport < ApplicationJob
    queue_as :default

    def perform(donation:)
      user = donation.user

      send_email(user)
    end

    private

    def send_email(user)
      SendgridWebMailer.send_email(receiver: user.email,
                                   dynamic_template_data: {},
                                   template_name: "user_free_bimonthly_report_template_id",
                                   language: user.language).deliver_later
    end
  end
end
