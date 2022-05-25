module Currency
  class Rates
    attr_reader :from, :to

    def initialize(from:, to:)
      @from = from
      @to = to
    end
    
    def get_rate()
      response = Request::ApiRequest.get("http://economia.awesomeapi.com.br/json/last/#{from}-#{to}")
      RecursiveOpenStruct.new(response["#{from}#{to}"]).ask
    end
  end
end
