class CreatePools < ActiveRecord::Migration[7.0]
  def change
    create_table :pools do |t|
      t.string :address
      t.references :token, null: false, foreign_key: true
      t.references :integration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
