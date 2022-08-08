FactoryBot.define do
  factory :integration_wallet do
    public_key { '0xdbce37c4431e394d7892a053cbc39a411bbf25d2' }
    after(:build) do |iw|
      ek = Web3::Utils::Cipher.encrypt('3ecf3128ad6df6257e693368e8860cd59b5ceee5f6550796efe841d4ccaed1c2')
      iw.encrypted_private_key = Base64.strict_encode64(ek.cipher_text)
      iw.private_key_iv = Base64.strict_encode64(ek.iv)
    end
  end
end
