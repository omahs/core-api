class Integration < ApplicationRecord
  has_one_attached :logo

  validates :url, :wallet_address, :name, :logo, presence: true
end
