# frozen_string_literal: true

require 'rails_helper'

describe Donations::UpdateFailedDonations do
  describe '.call' do
    subject(:command) { described_class.call }

    let!(:failed_transactions) { create_list(:donation_blockchain_transaction, 2, status: :failed) }
    let!(:success_transactions) { create_list(:donation_blockchain_transaction, 2, status: :success) }

    before do
      allow(Donations::CreateBlockchainDonation).to receive(:call)
    end

    it 'calls the Donations::CreateBlockchainDonation with failed transactions donations' do
      command

      failed_transactions.each do |transaction|
        expect(Donations::CreateBlockchainDonation)
          .to have_received(:call).with(donation: transaction.donation)
      end

      success_transactions.each do |transaction|
        expect(Donations::CreateBlockchainDonation)
          .not_to have_received(:call).with(donation: transaction.donation)
      end
    end
  end
end
