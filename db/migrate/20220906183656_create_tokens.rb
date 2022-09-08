class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.string :name
      t.string :address
      t.integer :decimals
      t.references :chain, index: true

      t.timestamps
    end
  end
end
