class CreateGivingValues < ActiveRecord::Migration[7.0]
  def change
    create_table :giving_values do |t|
      t.decimal :value
      t.integer :currency, default: 0

      t.timestamps
    end
  end
end
