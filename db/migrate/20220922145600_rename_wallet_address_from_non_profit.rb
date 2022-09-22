class RenameWalletAddressFromNonProfit < ActiveRecord::Migration[7.0]
  def change
    rename_column :non_profit, :wallet_address, :old_wallet_address
  end
end
