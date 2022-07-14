module PersonPaymentServices
  class BlockchainTransaction
    attr_reader :person_blockchain_transaction

    def initialize(person_blockchain_transaction:)
      @person_blockchain_transaction = person_blockchain_transaction
    end

    def update_status
      transaction_receipt = client.eth_get_transaction_receipt(person_blockchain_transaction.transaction_hash)
      status = transaction_receipt['result']['status']

      person_blockchain_transaction.update!(treasure_entry_status: treasure_entry_status_by(status))
    end

    private

    def client
      @client ||= Web3::Providers::Client.create(network:)
    end

    def network
      @network ||= Web3::Providers::Networks::MUMBAI
    end

    def treasure_entry_status_by(status)
      status_codes_map = { '0x0': :processing, '0x1': :success, '0x2': :failed }

      status_codes_map[status.to_sym]
    end
  end
end
