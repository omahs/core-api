FactoryBot.define do
  factory :donation_blockchain_transaction do
    donation { nil }
    chain { nil }
    transaction_hash { 'MyString' }
    status { 1 }
  end
end
