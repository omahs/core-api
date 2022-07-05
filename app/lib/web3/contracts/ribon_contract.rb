module Web3
  module Contracts
    class RibonContract < BaseContract
      private

      def client
        @client ||= Providers::Client.create(network:)
      end

      def contract_name
        'RibonContract'.freeze
      end

      def address
        (::Eth::Address.new network[:ribon_contract_address]).address
      end

      def abi
        File.read("#{Rails.root}/app/lib/web3/utils/ribon_abi.json")
      end
    end
  end
end
