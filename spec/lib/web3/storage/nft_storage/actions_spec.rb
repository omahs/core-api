require 'rails_helper'

RSpec.describe Web3::Storage::NftStorage::Actions do
  subject(:api_instance) { described_class.new }

  let(:nft_storage_instance) { instance_double(NFTStorage::NFTStorageAPI) }
  let(:cid) { 'pi_123' }

  describe '#delete' do
    before do
      allow(NFTStorage::NFTStorageAPI).to receive(:new).and_return(nft_storage_instance)
      allow(nft_storage_instance).to receive(:delete)
    end

    it 'creates an instance of NFTStorageAPI' do
      expect(api_instance).to be_instance_of(described_class)
    end

    it 'calls the delete with correct params' do
      api_instance.delete(cid:)

      expect(nft_storage_instance).to have_received(:delete).with(cid)
    end
  end

  describe '#list' do
    before do
      allow(NFTStorage::NFTStorageAPI).to receive(:new).and_return(nft_storage_instance)
      allow(nft_storage_instance).to receive(:list)
    end

    it 'calls list' do
      api_instance.list

      expect(nft_storage_instance).to have_received(:list)
    end
  end

  describe '#status' do
    before do
      allow(NFTStorage::NFTStorageAPI).to receive(:new).and_return(nft_storage_instance)
      allow(nft_storage_instance).to receive(:status)
    end

    it 'calls status with correct params' do
      api_instance.status(cid:)

      expect(nft_storage_instance).to have_received(:status).with(cid)
    end
  end

  describe '#store' do
    before do
      allow(NFTStorage::NFTStorageAPI).to receive(:new).and_return(nft_storage_instance)
      allow(nft_storage_instance).to receive(:store)
    end

    it 'calls status with correct params' do
      api_instance.store

      expect(nft_storage_instance).to have_received(:store)
    end
  end
end
