module Request
  class ApiRequest
    def self.get(url, expires_in: nil)
      response = RedisStore::Cache.find_or_create(key: url.parameterize, expires_in:) do
        HTTParty.get(url)
      end

      RecursiveOpenStruct.new(response)
    end

    def self.post(url, body:, headers: {})
      default_headers = { 'Content-Type' => 'application/json' }
      response = HTTParty.post(url, body:, headers: default_headers.merge(headers))

      RecursiveOpenStruct.new(response)
    end
  end
end
