module Request
  class ApiRequest
    def self.get(url, expires_in: nil)
      RedisStore::Cache.find_or_create(key: sanitized_url(url), expires_in: expires_in) do
        response = HTTParty.get(url)

        RecursiveOpenStruct.new(response)
      end
    end

    def self.sanitized_url(url)
      url.gsub(/[^0-9A-Za-z]/, '')
    end
  end
end
