class Integration < ApplicationRecord
  has_one :integration_wallet

  STATUSES = %w[active inactive].freeze
  validates :status, presence: true, inclusion: { in: STATUSES, message: '%<value>s is not a valid status' }

  validates :name, :unique_address, presence: true

  def integration_address
    "#{base_url}#{unique_address}"
  end

  def ticket_availability
    if ticket_availability_in_minutes.present?
      "#{ticket_availability_in_minutes} minutes"
    else
      'Everyday at midnight'
    end
  end

  def daily_availability?
    ticket_availability_in_minutes.nil?
  end

  private

  def base_url
    RibonCoreApi.config[:integration_address][:base_url]
  end
end
