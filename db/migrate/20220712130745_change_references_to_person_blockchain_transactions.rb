class ChangeReferencesToPersonBlockchainTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :person_blockchain_transactions, :customer_payment
    add_reference :person_blockchain_transactions, :person_payment, foreign_key: true
  end
end
