class CreateBlockchainTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :blockchain_transactions do |t|
      t.integer :status, default: 0
      t.string :transaction_hash
      t.references :chain, null: false, foreign_key: true
      t.references :owner, polymorphic: true, null: false

      t.timestamps
    end
  end
end
