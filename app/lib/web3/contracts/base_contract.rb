module Web3
  module Contracts
    class BaseContract
      attr_reader :chain

      def initialize(chain:)
        @chain = chain
      end

      def contract
        ::Eth::Contract.from_abi(name: contract_name, address:, abi:)
      end

      def call(function_name, *args, **kwargs)
        client.call(contract, function_name, *args, **kwargs.merge(default_args))
      end

      def transact(function_name, *args, **kwargs)
        client.transact(contract, function_name, *args, **kwargs.merge(default_args))
      end

      def transact_and_wait(function_name, *args, **kwargs)
        client.transact_and_wait(contract, function_name, *args, **kwargs.merge(default_args))
      end

      private

      def default_args
        {
          gas_limit: client.gas_limit
        }
      end

      def client
        @client ||= Providers::Client.create(chain:)
      end

      def contract_name; end

      def address; end

      def abi; end
    end
  end
end
