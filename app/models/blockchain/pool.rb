class Pool < ApplicationRecord
  validates :address, presence: true

  belongs_to :token
  belongs_to :integration

  delegate :chain, to: :token
end
