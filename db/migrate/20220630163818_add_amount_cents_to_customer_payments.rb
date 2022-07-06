class AddAmountCentsToCustomerPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_payments, :amount_cents, :integer
  end
end
