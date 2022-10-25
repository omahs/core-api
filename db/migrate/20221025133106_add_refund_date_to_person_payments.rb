class AddRefundDateToPersonPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :person_payments, :refund_date, :datetime
  end
end
