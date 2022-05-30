module GivingServices
  module Fees
    module Crypto
      class PolygonFeeCalculatorService
        attr_reader :currency

        def initialize(currency:)
          @currency = currency
        end

        def calculate_fee
          request = Request::ApiRequest.get(polygon_fee_url)
          gas_fee_in_usd = request.speeds.first['estimatedFee']

          formatted_gas_fee(gas_fee_in_usd)
        end

        private

        def polygon_fee_url
          RibonCoreApi.config[:crypto_api][:polygon_gas_fee_url]
        end

        def formatted_gas_fee(gas_fee_in_usd)
          Currency::Converters.convert(from: :usd, to: currency, value: gas_fee_in_usd)
        end
      end
    end
  end
end
