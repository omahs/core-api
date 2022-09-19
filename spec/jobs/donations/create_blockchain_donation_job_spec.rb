require 'rails_helper'

RSpec.describe Donations::CreateBlockchainDonationJob, type: :job do
  describe '#perform' do
    subject(:perform_job) { described_class.perform_now(donation) }

    let(:donation) { build(:donation) }
    let(:command) { Donations::CreateBlockchainDonation }

    before do
      allow(command).to receive(:call)
      perform_job
    end

    it 'calls the command with right params' do
      expect(command).to have_received(:call).with(donation:)
    end
  end
end
