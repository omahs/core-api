class Integration < ApplicationRecord
  has_one :integration_wallet

  STATUSES = %w[active inactive].freeze
  validates :status, presence: true, inclusion: { in: STATUSES, message: '%<value>s is not a valid status' }

  validates :name, :unique_address, presence: true

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
