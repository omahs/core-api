module Web3
  module Providers
    class Client
      def self.create(chain:)
        client = ::Eth::Client.create chain[:node_url]
        fees = Utils::Gas.new(chain:).estimate_gas

        client.max_fee_per_gas = fees.max_fee_per_gas * ::Eth::Unit::GWEI
        client.max_priority_fee_per_gas = fees.max_priority_fee_per_gas * ::Eth::Unit::GWEI
        client.gas_limit = fees.default_gas_limit

        client
      end
    end
  end
end
