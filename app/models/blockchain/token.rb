class Token < ApplicationRecord
  validates :name, :address, :decimals, presence: true

  belongs_to :chain
end
