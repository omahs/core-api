module Web3
  class Client
    DEFAULT_MAX_FEE_PER_GAS = 88 * ::Eth::Unit::GWEI
    DEFAULT_GAS_LIMIT = 58_659

    def self.create(network:)
      client = ::Eth::Client.create network[:node_url]
      client.max_fee_per_gas = DEFAULT_MAX_FEE_PER_GAS
      client.max_priority_fee_per_gas = DEFAULT_MAX_FEE_PER_GAS
      client.gas_limit = DEFAULT_GAS_LIMIT

      client
    end
  end
end
