class CreateHistory < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.bigint :total_donors
      t.bigint :total_donations

      t.timestamps
    end
  end
end
