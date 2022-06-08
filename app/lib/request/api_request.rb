module Request
  class ApiRequest
    def self.get(url, expires_in: nil)
      response = RedisStore::Cache.find_or_create(key: sanitized_url(url), expires_in: expires_in) do
        HTTParty.get(url)
      end

      RecursiveOpenStruct.new(response)
    end

    def self.sanitized_url(url)
      url.gsub(/[^0-9A-Za-z]/, '')
    end
  end
end
