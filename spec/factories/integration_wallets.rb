FactoryBot.define do
  encrypted_key = Web3::Utils::Cipher.encrypt('3ecf3128ad6df6257e693368e8860cd59b5ceee5f6550796efe841d4ccaed1c2')

  factory :integration_wallet do
    public_key { '0xdbce37c4431e394d7892a053cbc39a411bbf25d2' }
    encrypted_private_key { Base64.strict_encode64(encrypted_key.cipher_text) }
    private_key_iv { Base64.strict_encode64(encrypted_key.iv) }
  end
end
