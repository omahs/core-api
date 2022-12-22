# == Schema Information
#
# Table name: balance_histories
#
#  id             :bigint           not null, primary key
#  amount_donated :decimal(, )
#  balance        :decimal(, )
#  date           :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cause_id       :bigint           not null
#  pool_id        :bigint           not null
#
class BalanceHistory < ApplicationRecord
  belongs_to :cause
  belongs_to :pool

  validates_presence_of :balance, :amount_donated, :date
end
