# == Schema Information
#
# Table name: chains
#
#  id                              :bigint           not null, primary key
#  block_explorer_url              :string
#  currency_name                   :string
#  donation_token_contract_address :string
#  gas_fee_url                     :string
#  name                            :string
#  node_url                        :string
#  ribon_contract_address          :string
#  rpc_url                         :string
#  symbol_name                     :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  chain_id                        :integer
#
class Chain < ApplicationRecord
  validates :name, :ribon_contract_address, :donation_token_contract_address, :chain_id,
            :rpc_url, :node_url, :symbol_name, :currency_name, :block_explorer_url, presence: true

  has_many :tokens, dependent: :destroy

  def self.default
    default_chain_id = RibonConfig.default_chain_id

    find_by(chain_id: default_chain_id)
  end

  def gas_fee(currency: :usd)
    Web3::Utils::Fee.new(chain: self, currency:).estimate_fee
  end
end
