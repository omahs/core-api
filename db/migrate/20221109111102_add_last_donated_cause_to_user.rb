class AddLastDonatedCauseToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_donated_cause, :bigint, index: true
  end
end
