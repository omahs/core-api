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
#  type                  :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  owner_id              :bigint           not null
#
class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true

  enum status: {
    inactive: 0,
    active: 1
  }

  def private_key
    decrypted_pk = Base64.strict_decode64(encrypted_private_key)
    decrypted_pk_iv = Base64.strict_decode64(private_key_iv)

    Web3::Utils::Cipher.decrypt(decrypted_pk, decrypted_pk_iv).plain_text
  end
end
