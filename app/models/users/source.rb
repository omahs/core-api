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
# Indexes
#
#  index_sources_on_integration_id  (integration_id)
#  index_sources_on_user_id         (user_id)
#
class Source < ApplicationRecord
  has_one :user
  has_one :integration

  validates :user_id, :integration_id, presence: true
end
