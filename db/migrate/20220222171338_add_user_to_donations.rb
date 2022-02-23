class AddUserToDonations < ActiveRecord::Migration[7.0]
  def change
    add_reference :donations, :user, foreign_key: true
  end
end
