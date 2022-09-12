FactoryBot.define do
  factory :pool do
    address { '0xE00000000000000000000000000000000000000000000000' }
    token { build(:token) }
  end
end
