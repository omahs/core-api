module Givings
  module Payment
    class AddGivingToBlockchainJob < ApplicationJob
      queue_as :default
      sidekiq_options retry: 3

      def perform(amount:, payment:, pool: nil)
        transaction_hash = call_add_balance_command(amount, pool)
        payment.create_person_blockchain_transaction(treasure_entry_status: :processing, transaction_hash:)
      end

      private

      def call_add_balance_command(amount, pool)
        CommunityTreasure::AddBalance.call(amount:, pool:).result
      end
    end
  end
end
