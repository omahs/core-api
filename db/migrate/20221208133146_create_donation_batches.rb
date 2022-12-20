class CreateDonationBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :donation_batches do |t|
      t.references :donation, null: false, foreign_key: true
      t.references :batch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
