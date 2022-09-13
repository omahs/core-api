class ChangeStatusOnPersonPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :person_payments, :new_status, :integer

    execute "UPDATE person_payments SET new_status = 0 WHERE status = 'processing'"
    execute "UPDATE person_payments SET new_status = 1 WHERE status = 'paid'"
    execute "UPDATE person_payments SET new_status = 2 WHERE status = 'failed'"

    change_column_default :person_payments, :new_status, 0

    rename_column :person_payments, :status, :old_status
    rename_column :person_payments, :new_status, :status

    remove_column :person_payments, :old_status
  end
end
