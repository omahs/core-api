FactoryBot.define do
  factory :person do
    customer { build(:customer) }
    guest { build(:guest) }
  end
end
