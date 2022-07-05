module Web3
  module Contracts
    class RibonContract < BaseContract
      def add_donation_pool_balance(amount:, user:)
        keccak256_user = ::Eth::Util.keccak256(user)
        parsed_amount = Utils::Converter.to_wei(amount)

        transact('addDonationPoolBalance',
                 parsed_amount, keccak256_user, sender_key: Providers::Keys::RIBON_KEY)
      end

      def donate_through_integration(non_profit_wallet_address:, user:, amount:)
        keccak256_user = ::Eth::Util.keccak256(user)
        parsed_amount = Utils::Converter.to_wei(amount)

        transact('donateThroughIntegration',
                 non_profit_wallet_address, keccak256_user, parsed_amount,
                 sender_key: Providers::Keys::RIBON_KEY)
      end

      private

      def contract_name
        'RibonContract'.freeze
      end

      def address
        (::Eth::Address.new network[:ribon_contract_address]).address
      end

      def abi
        File.read("#{Rails.root}/app/lib/web3/utils/abis/ribon_abi.json")
      end
    end
  end
end
