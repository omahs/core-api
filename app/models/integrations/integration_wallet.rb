class IntegrationWallet < ApplicationRecord
  belongs_to :integration

  validates :public_key, :encrypted_private_key, :private_key_iv, presence: true

  def private_key
    decrypted_pk = Base64.decode64(encrypted_private_key)
    decrypted_pk_iv = Base64.decode64(private_key_iv)

    Web3::Utils::Cipher.decrypt(decrypted_pk, decrypted_pk_iv).plain_text
  end

  def add_balance(contract, amount)
    contract.add_integration_balance(integration_address: public_key, amount:)
  end
end
