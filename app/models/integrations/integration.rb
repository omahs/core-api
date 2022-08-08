class Integration < ApplicationRecord
  has_one :integration_wallet

  STATUSES = %w[active inactive].freeze
  validates :status, presence: true, inclusion: { in: STATUSES, message: '%<value>s is not a valid status' }

  validates :name, :unique_address, presence: true

  def integration_address
    "#{base_url}#{unique_address}"
  end

  private

  def base_url
    RibonCoreApi.config[:integration_address][:base_url]
  end
end
