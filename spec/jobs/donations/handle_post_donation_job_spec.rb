require 'rails_helper'

RSpec.describe Donations::HandlePostDonationJob, type: :job do
  describe '#perform' do
    subject(:perform_job) { described_class.perform_now(donation:) }

    let(:donation) { create(:donation) }

    before do
      allow(Mailers::SendDonationsEmailJob).to receive(:perform_later)
      perform_job
    end

    it 'calls the send donation email job' do
      expect(Mailers::SendDonationsEmailJob).to have_received(:perform_later).with(donation:)
    end
  end
end
