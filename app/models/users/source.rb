# == Schema Information
#
# Table name: sources
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint
#  user_id        :bigint
#
class Source < ApplicationRecord
  has_one :user
  has_one :integration

  validates :user_id, :integration_id, presence: true
end
