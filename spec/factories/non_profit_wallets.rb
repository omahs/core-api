# == Schema Information
#
# Table name: wallets
#
#  id                    :bigint           not null, primary key
#  encrypted_private_key :string
#  owner_type            :string           not null
#  private_key_iv        :string
#  public_key            :string
#  status                :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  owner_id              :bigint           not null
#
FactoryBot.define do
  factory :non_profit_wallet do
    status { :active }
    public_key { '0x6E060041D62fDd76cF27c582f62983b864878E8F' }
    owner { build(:non_profit) }
  end
end
