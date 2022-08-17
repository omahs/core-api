class UserDonationStats < ApplicationRecord
  belongs_to :user

  def can_donate?(integration)
    return true if next_donation_at(integration).nil?

    Time.zone.now >= next_donation_at(integration)
  end

  def next_donation_at(integration)
    time_interval = integration.ticket_availability_in_minutes

    return last_donation_at + time_interval.minutes if time_interval.present?
  
    last_donation_at&.next_day&.beginning_of_day
  end
end
