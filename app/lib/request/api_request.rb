module Request
  class ApiRequest
    def self.get(url, expires_in: nil)
      with_cache(cache_key: sanitized_url(url), expires_in: expires_in) do
        response = HTTParty.get(url)

        RecursiveOpenStruct.new(response)
      end
    end

    def self.with_cache(cache_key:, expires_in:, &block)
      return Rails.cache.fetch(cache_key, expires_in: expires_in, &block) if expires_in

      yield
    end

    def self.sanitized_url(url)
      url.gsub(/[^0-9A-Za-z]/, '')
    end
  end
end
