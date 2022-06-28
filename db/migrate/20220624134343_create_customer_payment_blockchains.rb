class CreateCustomerPaymentBlockchains < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_payment_blockchains do |t|
      t.integer :treasure_entry_status, default: 0
      t.references :customer_payment, null: false, foreign_key: true
      t.string :transaction_hash

      t.timestamps
    end
  end
end
