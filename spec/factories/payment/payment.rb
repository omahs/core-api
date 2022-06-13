FactoryBot.define do
  factory :payment, class: 'Payment::Register' do
    paid_date { "2021-09-20 12:20:41" }
    payment_method { :credit_card }
    status { :paid }
    association :customer, factory: :customer
    offer { build(:offer) }
  end
end
