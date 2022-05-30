module Currency
  class Converters
    extend Helpers
    attr_reader :value, :from, :to

    def initialize(value:, from:, to:)
      @value = value
      @from = from
      @to = to
    end

    def self.convert(value:, from:, to:)
      new(value: value, from: from, to: to).convert
    end

    def convert
      add_rate
      Money.from_amount(value, from)
           .exchange_to(to)
    end

    def add_rate
      Currency::Rates.new(from: from, to: to).add_rate
    end
  end
end
