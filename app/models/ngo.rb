class Ngo < ApplicationRecord
  has_one_attached :logo
  has_one_attached :mainImage
  has_one_attached :coverImage
  has_one_attached :backgroundImage
end
