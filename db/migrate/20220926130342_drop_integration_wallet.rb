class DropIntegrationWallet < ActiveRecord::Migration[7.0]
  def change
    drop_table :integration_wallets
  end
end
