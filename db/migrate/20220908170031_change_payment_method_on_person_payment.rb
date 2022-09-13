class ChangePaymentMethodOnPersonPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :person_payments, :new_payment_method, :integer

    execute "UPDATE person_payments SET new_payment_method = 0 WHERE payment_method = 'credit_card'"
    execute "UPDATE person_payments SET new_payment_method = 1 WHERE payment_method = 'pix'"
    execute "UPDATE person_payments SET new_payment_method = 2 WHERE payment_method = 'crypto'"

    rename_column :person_payments, :payment_method, :old_payment_method
    rename_column :person_payments, :new_payment_method, :payment_method

    remove_column :person_payments, :old_payment_method
  end
end
