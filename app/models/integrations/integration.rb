# == Schema Information
#
# Table name: integrations
#
#  id                             :bigint           not null, primary key
#  name                           :string
#  status                         :integer          default("inactive")
#  ticket_availability_in_minutes :integer
#  unique_address                 :uuid             not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
class Integration < ApplicationRecord
  has_many :integration_tasks

  has_one :integration_wallet, as: :owner

  has_one_attached :logo

  validates :name, :unique_address, :status, :logo, presence: true

  has_many :integration_pools
  has_many :pools, through: :integration_pools

  enum status: {
    inactive: 0,
    active: 1
  }

  def self.find_by_id_or_unique_address(id_or_address)
    return find_by(unique_address: id_or_address) if id_or_address.to_s.valid_uuid?

    find id_or_address
  end

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
