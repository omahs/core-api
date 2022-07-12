class Guest < ApplicationRecord
  include UuidHelper

  belongs_to :person
  validates :wallet_address, presence: true
end
