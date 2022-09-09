# == Schema Information
#
# Table name: tokens
#
#  id         :bigint           not null, primary key
#  address    :string
#  decimals   :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chain_id   :bigint
#
# Indexes
#
#  index_tokens_on_chain_id  (chain_id)
#
FactoryBot.define do
  factory :token do
    name { 'USDC' }
    address { '0xF000000000000000000000000000000000000000' }
    decimals { 6 }
    chain { build(:chain) }
  end
end
