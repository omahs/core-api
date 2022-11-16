class AddReceiverToPersonPayments < ActiveRecord::Migration[7.0]
  def change
    add_reference :person_payments, :receiver, polymorphic: true
  end
end
