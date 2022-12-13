require 'rails_helper'

RSpec.describe Donations::SendDonationBatchWorker, type: :worker do
  # describe '#perform' do
  #   subject(:worker) { described_class.new }

  #   let(:integration) { create(:integration) }
  #   let(:non_profit) { create(:non_profit) }

  #   it 'calls the SendDonationBatchWorker command to all companies with an email' do
  #     worker.perform
  #     expect(Donations::CreateDonationsBatch).to receive(:call)
  #   end
  # end

  describe '.perform_async' do
    it 'expects to enqueue a job' do
      expect do
        described_class.perform_async
      end.to change(described_class.jobs, :size).from(0).to(1)
    end

    it 'expects to add one job in the reminders queue' do
      expect do
        described_class.perform_async
      end.to change(Sidekiq::Queues['donations'], :size).by(1)
    end
  end
end
