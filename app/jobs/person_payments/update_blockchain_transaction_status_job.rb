module PersonPayments
  class UpdateBlockchainTransactionStatusJob < ApplicationJob
    queue_as :default
    sidekiq_options retry: 3

    def perform(person_blockchain_transaction)
      PersonPaymentServices::BlockchainTransaction.new(person_blockchain_transaction:).update_status
    end
  end
end
