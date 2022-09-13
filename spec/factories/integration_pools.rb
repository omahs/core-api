# == Schema Information
#
# Table name: integration_pools
#
#  id             :bigint           not null, primary key
#  integration_id :bigint           not null
#  pool_id        :bigint           not null
#
FactoryBot.define do
  factory :integration_pool do
    integration { build(:integration) }
    pool { build(:pool) }
  end
end
