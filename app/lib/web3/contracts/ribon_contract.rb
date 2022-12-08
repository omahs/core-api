module Web3
  module Contracts
    class RibonContract < BaseContract
      def add_pool_balance(donation_pool:, amount:)
        parsed_amount = Utils::Converter.to_decimals(amount, donation_pool.token.decimals)

        transact('addPoolBalance', donation_pool.address,
                 parsed_amount, sender_key: Providers::Keys::RIBON_KEY)
      end

      def add_integration_balance(integration_address:, amount:)
        parsed_amount = Utils::Converter.to_wei(amount)

        transact('addIntegrationBalance', integration_address, parsed_amount,
                 sender_key: Providers::Keys::RIBON_KEY)
      end

      def donate_through_integration(donation_pool:,
                                     non_profit_wallet_address:,
                                     integration_wallet_address:,
                                     user:,
                                     amount:)
        keccak256_user = Utils::Converter.keccak(user).to_s
        parsed_amount = Utils::Converter.to_decimals(amount, donation_pool.token.decimals)

        transact('donateThroughIntegration',
                 donation_pool.address,
                 non_profit_wallet_address,
                 integration_wallet_address,
                 keccak256_user,
                 parsed_amount,
                 sender_key: Providers::Keys::RIBON_KEY)
      end

      def create_pool(token:)
        gas_limit = gas_limit_for_create_pool
        hash = transact_and_wait('createPool', token, gas_limit:, sender_key: Providers::Keys::RIBON_KEY)
        wait_for_tx(hash)
        hash
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

      def gas_limit_for_create_pool
        client.gas_limit * 26
      end
    end
  end
end
