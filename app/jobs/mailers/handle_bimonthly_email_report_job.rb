module Mailers
  class HandleBimonthlyEmailReportJob < ApplicationJob
    queue_as :default

    def perform(user:)
      send_two_months_donation_email(user)
    rescue StandardError => e
      Reporter.log(error: e, extra: { message: e.message })
    end

    def send_two_months_donation_email(user)
      SendgridWebMailer.send_email(receiver: user.email,
                                   dynamic_template_data: dynamic_template_data(user),
                                   template_name: 'free_user_two_months_report_template_id',
                                   language: user.language).deliver_later
    end

    def dynamic_template_data(user)
      {
        months_active: months_active(user),
        total_donations_report: total_donations_report(user)
      }
    end

    def months_active(user)
      DateRange::Helper.new(start_date: Time.zone.now, end_date: user.last_donation_at).months_difference
    end

    def total_donations_report(user)
      user.donations.count
    end
  end
end
