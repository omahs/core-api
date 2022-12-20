require 'rails_helper'

RSpec.describe Donations::CreateBatchBlockchainDonationJob, type: :job do
  describe '#perform' do
    subject(:perform_job) { described_class.perform_now(non_profit:, integration:, batch:) }

    let(:non_profit) { build(:non_profit) }
    let(:integration) { build(:integration) }
    let(:batch) { build(:batch) }
    let(:command) { Donations::CreateBatchBlockchainDonation }

    before do
      allow(command).to receive(:call)
      perform_job
    end

    it 'calls the command with right params' do
      expect(command).to have_received(:call).with(non_profit:, integration:, batch:)
    end
  end
end
