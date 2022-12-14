require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Donations::SendDonationBatchJob, type: :job do
  include ActiveStorage::Blob::Analyzable

  describe '#perform' do
    subject(:job) { described_class.new }

    let(:integration) { create(:integration) }
    let(:non_profit) { create(:non_profit) }
    let(:result) do
      OpenStruct.new({
                       result: create(:batch)
                     })
    end

    before do
      allow(Donations::CreateDonationsBatch).to receive(:call).and_return(result)
    end

    it 'calls the CreateDonationsBatch command' do
      Donations::CreateDonationsBatch.call(non_profit:, integration:)

      expect(Donations::CreateDonationsBatch).to have_received(:call)

      job.perform
    end
  end
end
