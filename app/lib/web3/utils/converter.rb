module Web3
  module Utils
    class Converter
      WEI_CONVERT_FACTOR = 1_000_000_000_000_000_000

      def self.parse_wei(wei_value)
        wei_value / WEI_CONVERT_FACTOR
      end

      def self.to_wei(value)
        value * WEI_CONVERT_FACTOR
      end
    end
  end
end
