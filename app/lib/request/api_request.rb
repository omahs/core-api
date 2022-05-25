module Request
  class ApiRequest
    def self.get(url)
      request = HTTParty.get(url)
      OpenStruct.new(request)
    end
  end
end