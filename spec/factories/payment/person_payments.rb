FactoryBot.define do
  factory :person_payment do
    paid_date { '2021-09-20 12:20:41' }
    payment_method { :credit_card }
    status { :processing }
    integration_id { 1 }
    association :person, factory: :person
    offer { build(:offer) }
    external_id { 'pi_123' }
  end
end
