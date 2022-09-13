# == Schema Information
#
# Table name: non_profit_pools
#
#  id            :bigint           not null, primary key
#  non_profit_id :bigint           not null
#  pool_id       :bigint           not null
#
class NonProfitPool < ApplicationRecord
  belongs_to :non_profit
  belongs_to :pool
end
