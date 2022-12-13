# == Schema Information
#
# Table name: blockchain_transactions
#
#  id               :bigint           not null, primary key
#  owner_type       :string           not null
#  status           :integer          default("processing")
#  transaction_hash :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  chain_id         :bigint           not null
#  owner_id         :bigint           not null
#
FactoryBot.define do
  factory :blockchain_transaction do
    status { 1 }
    transaction_hash { 'MyString' }
    chain { nil }
    owner { nil }
  end
end
