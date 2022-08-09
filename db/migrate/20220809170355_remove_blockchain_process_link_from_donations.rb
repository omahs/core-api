class RemoveBlockchainProcessLinkFromDonations < ActiveRecord::Migration[7.0]
  def change
    remove_column :donations, :blockchain_process_link, :string
  end
end
