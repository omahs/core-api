require 'rails_helper'

RSpec.describe Givings::Payment::AddGivingToBlockchainJob, type: :job do
  describe '#perform' do
    subject(:perform_job) { described_class.perform_now(amount:, user_identifier:, payment:) }

    let(:result) { '0xFC02' }
    let(:amount) { 0.5 }
    let(:user_identifier) { build(:user).email }
    let(:payment) { create(:customer_payment) }
    let(:klass) { Givings::CommunityTreasure::AddBalance }

    before do
      allow(Givings::CommunityTreasure::AddBalance)
        .to receive(:call).and_return(command_double(klass:, result:))
      perform_job
    end

    it 'calls the Givings::CommunityTreasure::AddBalance with right params' do
      expect(klass).to have_received(:call).with(amount:, user_identifier:)
    end

    it 'creates a customer_payment_blockchain to the payment with correct params' do
      expect(payment.customer_payment_blockchain.treasure_entry_status).to eq 'processing'
      expect(payment.customer_payment_blockchain.transaction_hash).to eq result
    end
  end
end
