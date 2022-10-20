require 'rails_helper'

RSpec.describe Payment::Gateways::Stripe::Billing::Refund do
  describe '#create' do
    subject(:method_call) { described_class.create(stripe_payment_intent:) }

    let(:person_payment) { build(:person_payment, offer:, person:, amount_cents: 1) }

    let(:stripe_payment_intent) {  'pi_123' } 

    before do
      allow(::Stripe::Refund).to receive(:create)
    end

    it 'calls the Stripe::Refund with correct params' do
      method_call

      expect(::Stripe::Refund)
        .to have_received(:create)
        .with({ payment_intent: 'pi_123' })
    end
  end
end
