class Source < ApplicationRecord
  has_one :user
  has_one :integration

  validates :user_id, :integration_id, presence: true
end
