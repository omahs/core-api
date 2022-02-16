class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.references :non_profit, null: false, foreign_key: true
      t.references :integration, null: false, foreign_key: true
      t.string :blockchain_process_link

      t.timestamps
    end
  end
end
