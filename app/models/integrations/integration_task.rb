# == Schema Information
#
# Table name: integration_tasks
#
#  id             :bigint           not null, primary key
#  description    :string
#  link           :string
#  link_address   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#
class IntegrationTask < ApplicationRecord
  extend Mobility

  translates :description, :link, type: :string

  belongs_to :integration

  validates :description, presence: true
end
