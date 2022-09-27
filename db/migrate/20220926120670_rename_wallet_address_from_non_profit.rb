class RenameWalletAddressFromNonProfit < ActiveRecord::Migration[7.0]
  def change
    rename_column :non_profits, :wallet_address, :old_wallet_address
  end
end
