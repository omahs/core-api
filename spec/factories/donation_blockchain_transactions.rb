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
# Indexes
#
#  index_donation_blockchain_transactions_on_chain_id     (chain_id)
#  index_donation_blockchain_transactions_on_donation_id  (donation_id)
#
# Foreign Keys
#
#  fk_rails_...  (chain_id => chains.id)
#  fk_rails_...  (donation_id => donations.id)
#
FactoryBot.define do
  factory :donation_blockchain_transaction do
    donation { nil }
    chain { nil }
    transaction_hash { 'MyString' }
    status { 1 }
  end
end
