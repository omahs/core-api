# frozen_string_literal: true

module RedisStore
  class Entry
    attr_reader :value

    def initialize(value:, expires_in:)
      @value = value
      @created_at = Time.now.to_f
      @expires_in = expires_in
    end
  end
end
