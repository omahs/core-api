# frozen_string_literal: true

require 'rails_helper'

describe Donations::UpdateApiOnlyDonations do
  describe '.call' do
    subject(:command) { described_class.call }

    let!(:api_only_donation) { create(:donation) }
    let!(:donation_with_blockchain_transaction) { create(:donation) }

    before do
      allow(Donations::CreateBlockchainDonation).to receive(:call)
      create(:donation_blockchain_transaction, donation: donation_with_blockchain_transaction)
    end

    it 'calls the Donations::CreateBlockchainDonation with failed transactions donations' do
      command

      expect(Donations::CreateBlockchainDonation).to have_received(:call).with(donation: api_only_donation)
      expect(Donations::CreateBlockchainDonation)
        .not_to have_received(:call).with(donation: donation_with_blockchain_transaction)
    end
  end
end
