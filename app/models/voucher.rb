# == Schema Information
#
# Table name: vouchers
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  donation_id    :bigint           not null
#  external_id    :string
#  integration_id :bigint           not null
#
class Voucher < ApplicationRecord
  belongs_to :integration
  belongs_to :donation, optional: true

  validates :external_id, presence: true, uniqueness: { scope: :integration_id }
  validates :integration_id, presence: true
end
