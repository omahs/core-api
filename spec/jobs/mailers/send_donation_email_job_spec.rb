require 'rails_helper'

RSpec.describe Mailers::SendDonationEmailJob, type: :job do
  describe '#perform' do
    subject(:perform_job) { described_class.perform_now(donation:) }

    let(:donation) { create(:donation) }

    before do
      allow(Mailers::SendDonationEmailJob).to receive(:perform_later)
      perform_job
    end

    it 'calls the send donation email job' do
      expect(Mailers::SendDonationEmailJob).to have_received(:perform_later).with(donation:)
    end
  end
end
