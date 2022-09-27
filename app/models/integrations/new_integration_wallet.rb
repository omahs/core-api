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
class NewIntegrationWallet < Wallet
  validates :public_key, :encrypted_private_key, :private_key_iv, presence: true

  def integration
    owner
  end

  def add_balance(contract, amount)
    contract.add_integration_balance(integration_address: public_key, amount:)
  end
end
