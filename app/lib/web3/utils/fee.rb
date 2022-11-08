module Web3
  module Utils
    class Fee
      attr_reader :currency, :chain

      def initialize(chain:, currency:)
        @currency = currency
        @chain = chain
      end

      def estimate_fee
        request = Request::ApiRequest.get(chain.gas_fee_url, expires_in: 2.hours)
        gas_fee_in_usd = request['speeds'].second['estimatedFee']

        formatted_gas_fee(gas_fee_in_usd)
      end

      private

      def formatted_gas_fee(gas_fee_in_usd)
        Currency::Converters.convert(from: :usd, to: currency, value: gas_fee_in_usd)
      end
    end
  end
end
