class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.references :non_profit, null: false, foreign_key: true
      t.integer :position
      t.boolean :active

      t.timestamps
    end
  end
end
