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
class NonProfitWallet < Wallet

  validates :public_key, :status, presence: true

  after_save :inactivate_previous

  def inactivate_previous
    Wallet.where(owner_id:).where.not(id:).update(status: :inactive) if active?
  end
end
