# == Schema Information
#
# Table name: integrations
#
#  id                             :bigint           not null, primary key
#  name                           :string
#  status                         :integer          default(0)
#  ticket_availability_in_minutes :integer
#  unique_address                 :uuid             not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
class Integration < ApplicationRecord
  has_one :integration_wallet

  validates :name, :unique_address, :status, presence: true

  enum status: {
    inactive: 0,
    active: 1
  }

  def integration_address
    "#{base_url}#{unique_address}"
  end

  def available_everyday_at_midnight?
    ticket_availability_in_minutes.nil?
  end

  private

  def base_url
    RibonCoreApi.config[:integration_address][:base_url]
  end
end
