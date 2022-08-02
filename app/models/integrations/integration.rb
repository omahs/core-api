class Integration < ApplicationRecord
  has_one :integration_wallet

  enum status: { active: 0, inactive: 1 }

  validates :name, :status, :unique_address, presence: true

  def integration_address
    "#{base_url}#{unique_address}"
  end

  private

  def base_url
    RibonCoreApi.config[:integration_address][:base_url]
  end
end
