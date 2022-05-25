module Currency
  class Converters
    attr_reader :value, :from, :to

    def initialize(value:, from:, to:)
      @value = value
      @from = from
      @to = to
    end

    def convert
      Money.from_amount(value, from)
           .exchange_to(to).format
    end

    def add_rate
      rate = Currency::Rates.new(from: from, to: to).rate
      Money.add_rate(from, to, rate)
    end
  end
end
