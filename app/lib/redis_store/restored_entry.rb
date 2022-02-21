# frozen_string_literal: true

module RedisStore
  class RestoredEntry
    attr_reader :value

    def initialize(value:, expires_in:, created_at:)
      @value = value
      @created_at = created_at
      @expires_in = expires_in
    end

    def expired?
      return false if @expires_in.nil?

      Time.now.to_f > @created_at + @expires_in&.to_f
    end
  end
end
