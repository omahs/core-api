class CreateVouchers < ActiveRecord::Migration[7.0]
  def change
    create_table :vouchers do |t|
      t.string :external_id
      t.references :integration, null: false, foreign_key: true
      t.references :donation, foreign_key: true

      t.timestamps
    end
  end
end
