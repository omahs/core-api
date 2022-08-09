FactoryBot.define do
  factory :donation do
    non_profit { build(:non_profit) }
    integration { build(:integration) }
    user { build(:user) }
  end
end
