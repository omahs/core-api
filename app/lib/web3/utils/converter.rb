module Web3
  module Utils
    class Converter
      WEI_CONVERT_FACTOR = ::Eth::Unit::ETHER

      def self.parse_wei(wei_value)
        wei_value / WEI_CONVERT_FACTOR
      end

      def self.to_wei(value)
        value * WEI_CONVERT_FACTOR
      end

      def self.keccak(value, decimals = 256)
        Digest::Keccak.hexdigest(value, decimals)
      end

      def self.to_decimals(value, decimals)
        (value.to_f * (10**decimals)).to_i
      end
    end
  end
end
