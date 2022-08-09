module Web3
  module Providers
    class Client
      DEFAULT_MAX_FEE_PER_GAS = 88 * ::Eth::Unit::GWEI
      DEFAULT_GAS_LIMIT = 58_659

      def self.create(chain:)
        client = ::Eth::Client.create chain[:node_url]
        client.max_fee_per_gas = DEFAULT_MAX_FEE_PER_GAS
        client.max_priority_fee_per_gas = DEFAULT_MAX_FEE_PER_GAS
        client.gas_limit = DEFAULT_GAS_LIMIT

        client
      end
    end
  end
end
