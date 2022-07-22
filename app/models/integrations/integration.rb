class Integration < ApplicationRecord
  has_one_attached :logo
  enum status: { active: 0, inactive: 1 }

  validates :url, :wallet_address, :name, :logo, presence: true

  def integration_address
    "https://dapp.ribon.io/integration/#{id}"
  end
end
