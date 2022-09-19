# == Schema Information
#
# Table name: pools
#
#  id         :bigint           not null, primary key
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  token_id   :bigint           not null
#
class Pool < ApplicationRecord
  validates :address, presence: true

  belongs_to :token

  has_many :non_profit_pools
  has_many :non_profits, through: :non_profit_pools

  has_many :integration_pools
  has_many :integrations, through: :integration_pools

  has_one :cause

  delegate :chain, to: :token
end
