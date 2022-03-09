class UserDonationStats < ApplicationRecord
  belongs_to :user

  def can_donate?
    return true if next_donation_at.nil?

    Time.zone.now >= next_donation_at
  end

  def next_donation_at
    last_donation_at&.next_day&.beginning_of_day
  end
end
