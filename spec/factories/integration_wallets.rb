FactoryBot.define do
  factory :integration_wallet do
    public_key { '0xB000000000000000000000000000000000000000' }
    after(:build) do |iw|
      ek = Web3::Utils::Cipher.encrypt('0000000000000000000000000000000000000000000000000000000000000000')
      iw.encrypted_private_key = Base64.strict_encode64(ek.cipher_text)
      iw.private_key_iv = Base64.strict_encode64(ek.iv)
    end
  end
end
