module Web3
  module Utils
    class TransactionUtils
      attr_reader :chain

      def initialize(chain: default_chain)
        @chain = chain
      end

      def transaction_status(transaction_hash)
        transaction_receipt = client.eth_get_transaction_receipt(transaction_hash)
        status = transaction_receipt['result']['status']

        formatted_status(status)
      end

      private

      def client
        @client ||= Providers::Client.create(chain:)
      end

      def default_chain
        @default_chain ||= Chain.default
      end

      def formatted_status(blockchain_status)
        status_codes_map = { '0x0': :failed, '0x1': :success, '0x2': :processing }

        status_codes_map[blockchain_status.to_sym]
      end
    end
  end
end
