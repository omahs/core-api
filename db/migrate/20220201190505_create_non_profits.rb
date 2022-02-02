class CreateNonProfits < ActiveRecord::Migration[7.0]
  def change
    create_table :non_profits do |t|
      t.string :name
      t.string :wallet_address
      t.text :impact_description
      t.string :link

      t.timestamps
    end
  end
end
