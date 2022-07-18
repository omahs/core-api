FactoryBot.define do
  factory :source do
    user { build(:user) }
    integration { build(:integration) }
  end
end
