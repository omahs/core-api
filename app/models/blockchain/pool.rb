# == Schema Information
#
# Table name: pools
#
#  id             :bigint           not null, primary key
#  address        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#  token_id       :bigint           not null
#
class Pool < ApplicationRecord
  validates :address, presence: true

  belongs_to :token

  delegate :chain, to: :token
end
