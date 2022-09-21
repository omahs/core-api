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
class NonProfitWallet < Wallet
  validates :public_key, :status, presence: true

  after_save :inactivate_previous

  def non_profit
    owner
  end

  def inactivate_previous
    Wallet.where(owner_id:).where.not(id:).update(status: :inactive) if active?
  end
end
