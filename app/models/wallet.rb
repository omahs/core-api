# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  address    :string
#  owner_type :string           not null
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true

  enum status: {
    inactive: 0,
    active: 1
  }

  after_save :inactivate_previous, if: self.status.active?

  def inactivate_previous
    Wallet.where(owner_id: self.owner_id).where.not(id: self.id).update_all(status: :inactive)
  end
end
