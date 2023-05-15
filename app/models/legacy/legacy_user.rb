# == Schema Information
#
# Table name: legacy_users
#
#  id         :bigint           not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
class LegacyUser < ApplicationRecord
  belongs_to :user, optional: true

  validates :email, presence: true
end
