FactoryBot.define do
  factory :customer_payment_blockchain do
    treasure_entry_status { 1 }
    customer_payment { nil }
    transaction_hash { 'MyString' }
  end
end
