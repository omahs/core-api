module Givings
  module Payment
    class AddGivingToBlockchainJob < ApplicationJob
      queue_as :default
      sidekiq_options retry: 3

      def perform(amount:, payment:)
        transaction_hash = call_add_balance_command(amount)
        payment.create_customer_payment_blockchain(treasure_entry_status: :processing, transaction_hash:)
      end

      private

      def call_add_balance_command(amount)
        CommunityTreasure::AddBalance.call(amount:).result
      end
    end
  end
end
