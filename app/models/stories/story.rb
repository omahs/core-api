class Story < ApplicationRecord
  belongs_to :non_profit

  validates :title, :description, :position, :active, presence: true

  has_one_attached :image
end
