class AddBatchReferencesToDonationBlockchainTransaction < ActiveRecord::Migration[7.0]
  def change
    add_reference :donation_blockchain_transactions, :batch, null: false, foreign_key: true
  end
end
