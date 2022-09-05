class AddGasFeeUrlToChains < ActiveRecord::Migration[7.0]
  def change
    add_column :chains, :gas_fee_url, :string
  end
end
