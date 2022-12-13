# == Schema Information
#
# Table name: batches
#
#  id         :bigint           not null, primary key
#  cid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Batch < ApplicationRecord
  validates :cid, presence: true

  has_many :donations, through: :donation_batches

  has_many :blockchain_transactions, as: :owner
end
