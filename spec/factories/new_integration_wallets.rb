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
  factory :new_integration_wallet do
    public_key { '0xB000000000000000000000000000000000000000' }
    after(:build) do |iw|
      ek = Web3::Utils::Cipher.encrypt('0000000000000000000000000000000000000000000000000000000000000000')
      iw.encrypted_private_key = Base64.strict_encode64(ek.cipher_text)
      iw.private_key_iv = Base64.strict_encode64(ek.iv)
    end
  end
end
