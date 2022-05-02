class RibonConfig < ApplicationRecord
  before_create :confirm_singularity

  def self.app_config
    first
  end

  private

  def confirm_singularity
    raise StandardError, 'There can be only one.' if RibonConfig.count.positive?
  end
end
