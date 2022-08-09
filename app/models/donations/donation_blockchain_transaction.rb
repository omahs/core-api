class DonationBlockchainTransaction < ApplicationRecord
  belongs_to :donation
  belongs_to :chain

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
