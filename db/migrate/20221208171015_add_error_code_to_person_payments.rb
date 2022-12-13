class AddErrorCodeToPersonPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :person_payments, :error_code, :string
  end
end
