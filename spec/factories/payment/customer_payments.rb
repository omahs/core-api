FactoryBot.define do
  factory :customer_payment do
    paid_date { '2021-09-20 12:20:41' }
    payment_method { :credit_card }
    status { :paid }
    association :customer, factory: :customer
    offer { build(:offer) }
  end
end
