class CreateBadges < ActiveRecord::Migration[7.0]
  def change
    create_table :badges do |t|
      t.text :description
      t.integer :category
      t.integer :merit_badge_id
      t.string :name

      t.timestamps
    end
  end
end
