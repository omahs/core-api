class RibonConfig < ApplicationRecord
  validate :singularity, on: :create
  validates :default_ticket_value, presence: true

  before_destroy :stop_destroy

  def self.default_ticket_value
    first.default_ticket_value
  end

  private

  def singularity
    raise StandardError, 'There can be only one.' if RibonConfig.count.positive?
  rescue StandardError => e
    errors.add(:message, e.message)
  end

  def stop_destroy
    errors.add(:base, :undestroyable)
    throw :abort
  end
end
