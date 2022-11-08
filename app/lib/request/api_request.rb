module Request
  class ApiRequest
    def self.get(url, expires_in: nil)
      RedisStore::Cache.find_or_create(key: url.parameterize, expires_in:) do
        HTTParty.get(url)
      end
    end

    def self.post(url, body:, headers: {})
      default_headers = { 'Content-Type' => 'application/json' }
      HTTParty.post(url, body:, headers: default_headers.merge(headers))
    end
  end
end
