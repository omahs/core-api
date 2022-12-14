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
    chain { build(:chain) }
    transaction_hash { '0x000' }
    status { 1 }
    owner { build(:batch) }
  end
end
