class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }
end
