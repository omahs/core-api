class AddLastDonatedCauseToUserDonationStats < ActiveRecord::Migration[7.0]
  def change
    add_column :user_donation_stats, :last_donated_cause, :bigint, index: true
  end
end
