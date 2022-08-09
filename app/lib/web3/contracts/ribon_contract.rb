module Web3
  module Contracts
    class RibonContract < BaseContract
      def add_donation_pool_balance(amount:)
        parsed_amount = Utils::Converter.to_wei(amount)

        transact('addDonationPoolBalance', parsed_amount, sender_key: Providers::Keys::RIBON_KEY)
      end

      def donate_through_integration(non_profit_wallet_address:, user:,
                                     amount:, sender_key:)
        keccak256_user = Utils::Converter.keccak(user)
        parsed_amount = Utils::Converter.to_wei(amount)
        key = ::Eth::Key.new(priv: sender_key)

        transact('donateThroughIntegration', non_profit_wallet_address,
                 keccak256_user, parsed_amount, sender_key: key)
      end

      private

      def contract_name
        'RibonContract'.freeze
      end

      def address
        (::Eth::Address.new chain[:ribon_contract_address]).address
      end

      def abi
        File.read("#{Rails.root}/app/lib/web3/utils/abis/ribon_abi.json")
      end
    end
  end
end
