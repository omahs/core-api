# == Schema Information
#
# Table name: donation_blockchain_transactions
#
#  id               :bigint           not null, primary key
#  status           :integer          default("processing")
#  transaction_hash :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  chain_id         :bigint           not null
#  donation_id      :bigint           not null
#
FactoryBot.define do
  factory :donation_blockchain_transaction do
    donation { nil }
    chain { nil }
    transaction_hash { 'MyString' }
    status { 1 }
  end
end
