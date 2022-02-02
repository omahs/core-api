class NonProfit < ApplicationRecord
  has_one_attached :logo
  has_one_attached :main_image
  has_one_attached :background_image
  has_one_attached :cover_image
  has_many :non_profit_impacts

  validates :name, :impact_description, :wallet_address, presence: true
end
