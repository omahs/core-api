class Integration < ApplicationRecord
  has_one_attached :logo
  enum status: [:active, :inactive]

  validates :url, :wallet_address, :name, :logo, presence: true

  def integration_address
    "https://dapp.ribon.io/integration/#{id}"
  end
end
