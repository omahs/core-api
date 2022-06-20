class CreateCustomerPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_payments do |t|
      t.datetime :paid_date
      t.string :payment_method
      t.string :status
      t.references :customer, index: true, type: :uuid

      t.timestamps
    end
  end
end
