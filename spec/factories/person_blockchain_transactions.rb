# == Schema Information
#
# Table name: person_blockchain_transactions
#
#  id                    :bigint           not null, primary key
#  transaction_hash      :string
#  treasure_entry_status :integer          default("processing")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  person_payment_id     :bigint
#
FactoryBot.define do
  factory :person_blockchain_transaction do
    treasure_entry_status { 0 }
    association :person_payment, factory: :person_payment
    transaction_hash { '0x44d5e936dad202ec600b6a6a5252ef32c0e29bb9a21b179e348d2e8029cc1c86' }
  end
end
