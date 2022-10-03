class AddDonationStreakToUserDonationStats < ActiveRecord::Migration[7.0]
  def change
    add_column :user_donation_stats, :donation_streak, :integer, default: 0
  end
end
