FactoryBot.define do
  factory :person_blockchain_transaction do
    treasure_entry_status { 0 }
    association :person_payment, factory: :person_payment
    transaction_hash { '0x0000000000000000000000000000000000000000000000000000000000000000' }
  end
end
