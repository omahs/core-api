FactoryBot.define do
  factory :person_payment do
    paid_date { '2021-09-20 12:20:41' }
    payment_method { :credit_card }
    status { :paid }
    association :person, factory: :person
    offer { build(:offer) }
  end
end
