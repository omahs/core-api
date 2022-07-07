module Givings
  module Payments
    class AddGivingToBlockchainJob < ApplicationJob
      queue_as :default
      sidekiq_options retry: 3

      def perform(amount:, user_identifier:, payment:)
        transaction_hash = call_add_balance_command(amount, user_identifier)
        payment.create_customer_payment_blockchain(treasure_entry_status: :processing, transaction_hash:)
      end

      private

      def call_add_balance_command(amount, user_identifier)
        Givings::CommunityTreasure::AddBalance.call(amount:, user_identifier:).result
      end
    end
  end
end
