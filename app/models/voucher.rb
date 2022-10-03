# == Schema Information
#
# Table name: vouchers
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  donation_id    :bigint
#  external_id    :string
#  integration_id :bigint           not null
#
class Voucher < ApplicationRecord
  belongs_to :integration
  belongs_to :donation, optional: true

  validates :external_id, presence: true, uniqueness: { scope: :integration_id }

  def callback_url
    URI.join(Rails.application.routes.default_url_options[:host], "/vouchers/#{external_id}").to_s
  end
end
