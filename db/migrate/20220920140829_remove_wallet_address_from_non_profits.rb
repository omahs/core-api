class RemoveWalletAddressFromNonProfits < ActiveRecord::Migration[7.0]
  def change
    remove_column :non_profits, :wallet_address
  end
end
