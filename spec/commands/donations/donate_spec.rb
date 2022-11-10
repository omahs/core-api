# frozen_string_literal: true

require 'rails_helper'

describe Donations::Donate do
  describe '.call' do
    subject(:command) { described_class.call(integration:, non_profit:, user:) }

    context 'when no error occurs' do
      let(:integration) { build(:integration) }
      let(:non_profit) { build(:non_profit) }
      let(:user) { build(:user) }
      let(:donation) { create(:donation, created_at: DateTime.parse('2021-01-12 10:00:00')) }
      let(:default_chain_id) { 0x13881 }
      let(:donation_pool_address) { '0x841cad54aaeAdFc9191fb14EB09232af8E20be0F' }

      before do
        allow(Donation).to receive(:create!).and_return(donation)
        allow(Donations::CreateBlockchainDonationJob).to receive(:perform_later)
        allow(Donations::SetUserLastDonationAt).to receive(:call)
          .and_return(command_double(klass: Donations::SetUserLastDonationAt))
        allow(Donations::SetLastDonatedCause).to receive(:call)
          .and_return(command_double(klass: Donations::SetLastDonatedCause))
        allow(donation).to receive(:save)
        allow(user).to receive(:can_donate?).and_return(true)
        create(:ribon_config, default_ticket_value: 100)
        create(:chain, chain_id: default_chain_id)
      end

      it 'creates a donation in database' do
        command

        expect(Donation).to have_received(:create!).with(integration:, non_profit:, user:, value: 100)
      end

      it 'calls the donation in contract' do
        command

        expect(Donations::CreateBlockchainDonationJob).to have_received(:perform_later).with(donation)
      end

      it 'calls the Donations::SetUserLastDonationAt' do
        command

        expect(Donations::SetUserLastDonationAt)
          .to have_received(:call).with(user:, date_to_set: donation.created_at)
      end

      it 'calls the Donations::SetLastDonatedCause' do
        command

        expect(Donations::SetLastDonatedCause)
          .to have_received(:call).with(user:, cause: non_profit.cause)
      end

      it 'returns the donation created' do
        expect(command.result).to eq donation
      end
    end

    context 'when an error occurs at the validation process' do
      let(:integration) { build(:integration) }
      let(:non_profit) { build(:non_profit) }
      let(:user) { build(:user) }
      let(:donation) { build(:donation) }
      let(:ribon_contract) { instance_double(Web3::Contracts::RibonContract) }
      let(:default_chain_id) { 0x13881 }

      before do
        allow(Donation).to receive(:create!).and_return(donation)
        allow(Web3::Contracts::RibonContract).to receive(:new).and_return(ribon_contract)
        allow(ribon_contract).to receive(:donate_through_integration).and_return('0xFF20')
        allow(Donations::SetUserLastDonationAt).to receive(:call)
          .and_return(command_double(klass: Donations::SetUserLastDonationAt))
        allow(donation).to receive(:save)
        allow(user).to receive(:can_donate?).and_return(false)
        create(:ribon_config, default_ticket_value: 100)
        create(:chain, chain_id: default_chain_id)
      end

      it 'does not create the donation on the database' do
        expect { command }.not_to change(Donation, :count)
      end

      it 'returns nil' do
        expect(command.result).to be_nil
      end

      it 'returns an error' do
        expect(command.errors).to be_present
      end

      it 'returns an error message' do
        expect(command.errors[:message]).to eq ['Unable to donate now. Wait for your next donation.']
      end
    end

    context 'when an error occurs at the blockchain process' do
      let(:integration) { create(:integration) }
      let(:non_profit) { create(:non_profit) }
      let(:user) { create(:user) }

      before do
        create(:ribon_config, default_ticket_value: 100)
      end

      it 'still creates the donation on the database' do
        expect { command }.to change(Donation, :count).by(1)
      end

      it 'returns the new donation' do
        expect(command.result).to be_an_instance_of(Donation)
      end
    end
  end
end
