module Currency
  class Converters
    attr_reader :value

    def initialize(value:)
      @value = value
    end
    
    def convert(from:, to:)
      Money.from_amount(value, from)
      .exchange_to(to)
    end

    def get_rate()
    end
  end
end