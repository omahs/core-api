# frozen_string_literal: true

require 'rails_helper'

describe Donations::CreateBlockchainDonation do
  describe '.call' do
    subject(:command) { described_class.call(donation:) }

    context 'when no error occurs' do
      let(:integration) { create(:integration) }
      let(:non_profit) { create(:non_profit) }
      let(:user) { create(:user) }
      let(:donation) do
        create(:donation, created_at: DateTime.parse('2021-01-12 10:00:00', user:, non_profit:, integration:))
      end
      let(:ribon_contract) { instance_double(Web3::Contracts::RibonContract) }
      let(:default_chain_id) { 0x13881 }
      let(:donation_pool_address) { '0x841cad54aaeAdFc9191fb14EB09232af8E20be0F' }

      before do
        allow(Web3::Contracts::RibonContract).to receive(:new).and_return(ribon_contract)
        allow(ribon_contract).to receive(:donate_through_integration).and_return('0xFF20')
        create(:ribon_config, default_ticket_value: 100)
        create(:chain, chain_id: default_chain_id)
      end

      it 'calls the donation in contract' do
        command

        expect(ribon_contract).to have_received(:donate_through_integration)
          .with(donation_pool_address:, amount: 1.0,
                non_profit_wallet_address: non_profit.wallet_address, user: user.email,
                sender_key: integration.integration_wallet.private_key)
      end

      it 'creates donation_blockchain_transaction for the donation' do
        command

        expect(donation.donation_blockchain_transaction.transaction_hash).to eq '0xFF20'
        expect(donation.donation_blockchain_transaction.chain.chain_id).to eq default_chain_id
      end

      it 'returns the donation blockchain transaction' do
        expect(command.result.transaction_hash).to eq '0xFF20'
      end
    end

    context 'when an error occurs at the blockchain process' do
      let(:integration) { create(:integration) }
      let(:non_profit) { create(:non_profit) }
      let(:user) { create(:user) }
      let(:donation) { create(:donation, integration:, non_profit:, user:) }
      let(:ribon_contract) { instance_double(Web3::Contracts::RibonContract) }

      before do
        create(:ribon_config, default_ticket_value: 100)
        allow(Web3::Contracts::RibonContract).to receive(:new).and_return(ribon_contract)
        allow(ribon_contract).to receive(:donate_through_integration)
          .and_raise(StandardError.new('error message'))
      end

      it 'raises the error' do
        expect { command }.to raise_error(StandardError)
      end
    end
  end
end
