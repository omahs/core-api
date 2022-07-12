class ChangeReferencesToPersonPayment < ActiveRecord::Migration[7.0]
  def change
    remove_reference :person_payments, :customer
    add_reference :person_payments, :person, foreign_key: true, type: :uuid
  end
end
