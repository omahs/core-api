class CreateCustomerPaymentFees < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_payment_fees do |t|
      t.integer :card_fee_cents
      t.integer :crypto_fee_cents
      t.references :customer_payment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
