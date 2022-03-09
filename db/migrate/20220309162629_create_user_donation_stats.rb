class CreateUserDonationStats < ActiveRecord::Migration[7.0]
  def change
    create_table :user_donation_stats do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :last_donation_at

      t.timestamps
    end
  end
end
