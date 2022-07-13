require 'rails_helper'

RSpec.describe PersonPayments::UpdateBlockchainTransactionStatusJob, type: :job do
  describe '#perform' do
    subject(:perform_job) { described_class.perform_now(person_blockchain_transaction) }

    let(:person_blockchain_transaction) { build(:person_blockchain_transaction) }
    let(:service) { PersonPaymentServices::BlockchainTransaction }
    let(:service_mock) { instance_double(service) }

    before do
      allow(service).to receive(:new).and_return(service_mock)
      allow(service_mock).to receive(:update_status)
      perform_job
    end

    it 'calls the service with right params' do
      expect(service).to have_received(:new).with(person_blockchain_transaction:)
      expect(service_mock).to have_received(:update_status)
    end
  end
end
