# == Schema Information
#
# Table name: pool_balances
#
#  id         :bigint           not null, primary key
#  balance    :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pool_id    :bigint           not null
#
class PoolBalance < ApplicationRecord
  belongs_to :pool

  validates :balance, presence: true
end
