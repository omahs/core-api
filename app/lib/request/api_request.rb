module Request
  class ApiRequest
    def self.get(url)
      HTTParty.get(url)
    end
  end
end
