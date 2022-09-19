class CreateCauses < ActiveRecord::Migration[7.0]
  def change
    create_table :causes do |t|
      t.string :name
      t.references :pool, null: false, foreign_key: true
    end
  end
end
