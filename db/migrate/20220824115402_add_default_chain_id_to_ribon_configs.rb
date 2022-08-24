class AddDefaultChainIdToRibonConfigs < ActiveRecord::Migration[7.0]
  def change
    add_column :ribon_configs, :default_chain_id, :integer
  end
end
