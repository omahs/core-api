require 'rails_helper'

RSpec.describe Web3::Utils::TransactionUtils do
  subject(:transaction_utils) { described_class.new(chain:) }

  describe '#transaction_status' do
    let(:client_mock) { instance_double(Eth::Client) }
    let(:transaction_receipt) do
      { 'result' => { 'status' => status } }
    end
    let(:status) { nil }
    let(:chain) { build(:chain) }
    let(:hash) { '0xFF20' }

    before do
      allow(Web3::Providers::Client).to receive(:create).and_return(client_mock)
      allow(client_mock).to receive(:eth_get_transaction_receipt).and_return(transaction_receipt)
    end

    context 'when the status is (0x1)' do
      let(:status) { '0x1' }

      it 'returns success' do
        expect(transaction_utils.transaction_status(hash)).to eq :success
      end
    end

    context 'when the status is (0x0)' do
      let(:status) { '0x0' }

      it 'returns failed' do
        expect(transaction_utils.transaction_status(hash)).to eq :failed
      end
    end
  end
end
