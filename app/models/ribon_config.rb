class RibonConfig < ApplicationRecord
  validate :singularity
  validates :default_ticket_value, presence: true

  def self.default_ticket_value
    first.default_ticket_value
  end

  private

  def singularity
    raise StandardError, 'There can be only one.' if RibonConfig.count.positive?
  rescue StandardError => e
    errors.add(:message, e.message)
  end
end
