class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.integer :currency
      t.integer :price_cents
      t.boolean :subscription
      t.boolean :active
      t.integer :position_order
      t.string :title

      t.timestamps
    end
  end
end
