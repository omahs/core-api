# frozen_string_literal: true

require 'rails_helper'

describe Donations::CreateDonationsBatch do
  describe '.call' do
    subject(:command) { described_class.new(integration:, non_profit:) }

    include_context('when mocking a request') { let(:cassette_name) { 'create_donations_batch' } }

    let(:integration) { create(:integration) }
    let(:non_profit) { create(:non_profit) }
    let(:batch) { create(:batch) }
    let(:batch_file) { File.read("#{Rails.root}/app/lib/web3/utils/donation_batch.json") }
    let(:ntf_storage) { Web3::Storage::NftStorage::Actions.new }
    let(:ntf_storage_base) { Web3::Storage::NftStorage::Base.new }
    let(:result) { Web3::Storage::NftStorage::Actions.new.store(file: batch_file) }

    before do
      allow(Batch).to receive(:create).and_return(batch)
      allow(DonationBatch).to receive(:create)
      allow(ntf_storage).to receive(:store)
      allow(ntf_storage_base).to receive(:store)
      create(:donation, integration:, non_profit:)
    end

    it 'creates a batch in database' do
      command.call

      expect(Batch).to have_received(:create)
    end

    it 'creates a donation_batch in database' do
      command.call

      expect(DonationBatch).to have_received(:create)
    end
  end
end
