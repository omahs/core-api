class ChangeIntegrationIdFromPersonPayment < ActiveRecord::Migration[7.0]
  def change
    rename_column :person_payments, :integration_id, :old_integration_id
    add_reference :person_payments, :integration, foreign_key: true

    execute "UPDATE person_payments SET integration_id = 1"

    remove_column :person_payments, :old_integration_id
  end
end
