FactoryBot.define do
  factory :user_donation_stats do
    user { build(:user) }
    last_donation_at { '2022-03-09 13:26:30' }
  end
end
