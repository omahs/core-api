# == Schema Information
#
# Table name: integration_wallets
#
#  id                    :uuid             not null, primary key
#  encrypted_private_key :string
#  private_key_iv        :string
#  public_key            :string
#  integration_id        :bigint
#
# Indexes
#
#  index_integration_wallets_on_integration_id  (integration_id)
#
class IntegrationWallet < ApplicationRecord
  belongs_to :integration

  validates :public_key, :encrypted_private_key, :private_key_iv, presence: true

  def private_key
    decrypted_pk = Base64.strict_decode64(encrypted_private_key)
    decrypted_pk_iv = Base64.strict_decode64(private_key_iv)

    Web3::Utils::Cipher.decrypt(decrypted_pk, decrypted_pk_iv).plain_text
  end

  def add_balance(contract, amount)
    contract.add_integration_balance(integration_address: public_key, amount:)
  end
end
