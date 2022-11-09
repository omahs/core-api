class FetchPoolsQuery
  attr_accessor :data, :errors, :extensions, :original_hash
end

class PoolsQuery
  attr_accessor :pools
end

class PoolQuery
  attr_accessor :id, :balance
end

FactoryBot.define do
  factory :pool_query do
    id { '0xdaaa2e4b502d60362084ee822c7753567625f4b9' }
    balance { 0 }
  end

  factory :pools_query do
    pools { [build(:pool_query)] }
  end

  factory :fetch_pools_query do
    errors { '' }
    extensions { '' }
    original_hash { '' }
    data { build(:pools_query) }
  end
end
