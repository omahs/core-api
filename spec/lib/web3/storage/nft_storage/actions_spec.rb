require 'rails_helper'

RSpec.describe Web3::Storage::NftStorage::Actions do
  subject(:api_instance) { described_class.new }

  let(:nft_storage_instance) { instance_double(Web3::Storage::NftStorage::Base) }
  let(:cid) { 'pi_123' }
  let(:file) { 'file' }

  describe '#delete' do
    before do
      allow(Web3::Storage::NftStorage::Base).to receive(:new).and_return(nft_storage_instance)
      allow(nft_storage_instance).to receive(:delete)
    end

    it 'calls the delete with correct params' do
      api_instance.delete(cid:)

      expect(nft_storage_instance).to have_received(:delete).with(cid:)
    end
  end

  describe '#list' do
    before do
      allow(Web3::Storage::NftStorage::Base).to receive(:new).and_return(nft_storage_instance)
      allow(nft_storage_instance).to receive(:list)
    end

    it 'calls list' do
      api_instance.list

      expect(nft_storage_instance).to have_received(:list)
    end
  end

  describe '#store' do
    before do
      allow(Web3::Storage::NftStorage::Base).to receive(:new).and_return(nft_storage_instance)
      allow(nft_storage_instance).to receive(:store)
    end

    it 'calls status with correct params' do
      api_instance.store(file:)

      expect(nft_storage_instance).to have_received(:store).with(file:)
    end
  end
end
