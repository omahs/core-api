module Request
  class ApiRequest
    def self.get(url)
      response = HTTParty.get(url)

      RecursiveOpenStruct.new(response)
    end
  end
end
