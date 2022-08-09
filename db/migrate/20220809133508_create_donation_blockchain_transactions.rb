class CreateDonationBlockchainTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :donation_blockchain_transactions do |t|
      t.references :donation, null: false, foreign_key: true
      t.references :chain, null: false, foreign_key: true
      t.string :transaction_hash
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
