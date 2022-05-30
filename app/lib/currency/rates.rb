module Currency
  class Rates
    attr_reader :from, :to

    def initialize(from:, to:)
      @from = from
      @to = to
    end

    def add_rate
      Money.add_rate(from, to, rate)
    end

    def rate
      response = Request::ApiRequest.get(request_url)
      response["#{from.upcase}#{to.upcase}"].ask
    end

    private

    def request_url
      "#{RibonCoreApi.config[:currency_api][:url]}#{from}-#{to}"
    end
  end
end
