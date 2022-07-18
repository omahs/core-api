class Sources < ApplicationRecord
  has_one :user
  has_one :integration
end
