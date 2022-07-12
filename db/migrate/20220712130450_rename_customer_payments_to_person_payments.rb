class RenameCustomerPaymentsToPersonPayments < ActiveRecord::Migration[7.0]
  def change
    rename_table :customer_payments, :person_payments
  end
end
