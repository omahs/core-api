# == Schema Information
#
# Table name: blockchain_transactions
#
#  id               :bigint           not null, primary key
#  owner_type       :string           not null
#  status           :integer          default("processing")
#  transaction_hash :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  chain_id         :bigint           not null
#  owner_id         :bigint           not null
#
class BlockchainTransaction < ApplicationRecord
  belongs_to :chain
  belongs_to :owner, polymorphic: true

  validates :transaction_hash, presence: true

  enum status: {
    processing: 0,
    success: 1,
    failed: 2
  }

  def transaction_link
    "#{chain.block_explorer_url}tx/#{transaction_hash}"
  end
end
