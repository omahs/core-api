# frozen_string_literal: true

module RedisStore
  class RestoredEntry
    attr_reader :value

    def initialize(args)
      @value = args[:value]
      @created_at = args[:created_at]
      @expires_in = args[:expires_in]
    end

    def expired?
      return false if @expires_in.nil?

      Time.now.to_f > @created_at + @expires_in&.to_f
    end
  end
end
