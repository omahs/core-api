module Web3
  module Contracts
    class BaseContract
      attr_reader :network

      def initialize(network:)
        @network = network
      end

      def contract
        ::Eth::Contract.from_abi(name: contract_name, address:, abi:)
      end

      def call(function_name, *args, **kwargs)
        client.call(contract, function_name, *args, **kwargs)
      end

      def transact(function_name, *args, **kwargs)
        client.transact(contract, function_name, *args, **kwargs)
      end

      private

      def client
        @client ||= Providers::Client.create(network:)
      end

      def contract_name; end

      def address; end

      def abi; end
    end
  end
end
