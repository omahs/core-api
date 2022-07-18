class Source < ApplicationRecord
  has_one :user
  has_one :integration
end
