class CreateChains < ActiveRecord::Migration[7.0]
  def change
    create_table :chains do |t|
      t.string :name
      t.string :ribon_contract_address
      t.string :donation_token_contract_address
      t.integer :chain_id
      t.string :rpc_url
      t.string :node_url
      t.string :symbol_name
      t.string :currency_name
      t.string :block_explorer_url

      t.timestamps
    end
  end
end
