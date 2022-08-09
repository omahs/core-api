class Chain < ApplicationRecord
  validates :name, :ribon_contract_address, :donation_token_contract_address, :chain_id,
            :rpc_url, :node_url, :symbol_name, :currency_name, :block_explorer_url, presence: true

  def self.default
    default_chain_id = 0x13881 # MUMBAI Polygon

    find_by(chain_id: default_chain_id)
  end
end
