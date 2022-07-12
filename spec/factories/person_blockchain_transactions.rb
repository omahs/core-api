FactoryBot.define do
  factory :person_blockchain_transactions do
    treasure_entry_status { 0 }
    person_payment { nil }
    transaction_hash { '0x44d5e936dad202ec600b6a6a5252ef32c0e29bb9a21b179e348d2e8029cc1c86' }
  end
end
