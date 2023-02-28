class AddExternalIdToPersonPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :person_payments, :external_id, :string
  end
end
