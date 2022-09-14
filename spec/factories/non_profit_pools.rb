# == Schema Information
#
# Table name: non_profit_pools
#
#  id            :bigint           not null, primary key
#  non_profit_id :bigint           not null
#  pool_id       :bigint           not null
#
FactoryBot.define do
  factory :non_profit_pool do
    non_profit { build(:non_profit) }
    pool { build(:pool) }
  end
end
