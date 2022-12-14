# == Schema Information
#
# Table name: batches
#
#  id         :bigint           not null, primary key
#  cid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Batch < ApplicationRecord
  validates :cid, presence: true

  has_many :donations, through: :donation_batches

  has_many :blockchain_transactions, as: :owner

  def blockchain_transaction
    blockchain_transactions.last
  end

  def create_batch_blockchain_transaction(transaction_hash:, chain:)
    blockchain_transactions.create(transaction_hash:, chain:)
  end
end
