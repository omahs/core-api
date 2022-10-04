class AddIntegrationIdToPersonPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :person_payments, :integration_id, :bigint
  end
end
