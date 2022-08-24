require 'rails_helper'

RSpec.describe PersonPaymentServices::BlockchainTransaction, type: :service do
  subject(:service) { described_class.new(person_blockchain_transaction:) }

  describe '#update_status' do
    let(:client_mock) { instance_double(Eth::Client) }
    let(:transaction_receipt) do
      { 'result' => { 'status' => status } }
    end
    let(:status) { nil }
    let(:person_blockchain_transaction) do
      create(:person_blockchain_transaction, treasure_entry_status: :processing)
    end

    before do
      allow(Web3::Providers::Client).to receive(:create).and_return(client_mock)
      allow(client_mock).to receive(:eth_get_transaction_receipt).and_return(transaction_receipt)
    end

    context 'when the status is success (0x1)' do
      let(:status) { '0x1' }

      it 'updates the person_blockchain_transaction treasure_entry_status to success' do
        service.update_status

        expect(person_blockchain_transaction.reload.treasure_entry_status).to eq 'success'
      end
    end

    context 'when the status is fail (0x0)' do
      let(:status) { '0x0' }

      it 'updates the person_blockchain_transaction treasure_entry_status to failed' do
        service.update_status

        expect(person_blockchain_transaction.reload.treasure_entry_status).to eq 'failed'
      end
    end
  end
end
