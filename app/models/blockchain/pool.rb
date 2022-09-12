class Pool < ApplicationRecord
  validates :address, presence: true

  belongs_to :token

  delegate :chain, to: :token
end
