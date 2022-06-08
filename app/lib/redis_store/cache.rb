# frozen_string_literal: true

module RedisStore
  module Cache
    module_function

    def cache(key: nil, expires_in: nil, &block)
      return Rails.cache.fetch(key, expires_in: expires_in, &block) if expires_in

      yield
    end
  end
end
