FactoryBot.define do
  factory :legacy_user do
    email { "legacy@user.com" }
    user { build(:user) }
  end
end
