class DropOldWalletAddressFromNonProfit < ActiveRecord::Migration[7.0]
  def change
    remove_column :non_profits, :old_wallet_address
  end
end
