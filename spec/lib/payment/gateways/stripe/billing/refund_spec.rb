require 'rails_helper'

RSpec.describe Payment::Gateways::Stripe::Billing::Refund do
  describe '#create' do
    subject(:method_call) { described_class.create(stripe_customer:, offer:) }

    let!(:price_cents) { 100 }

    let(:offer) { create(:offer, price_cents:, subscription: true) }
    let(:stripe_customer) { OpenStruct.new({ id: 'cus_123' }) }

    before do
      allow(::Stripe::Refund).to receive(:create)
    end

    it 'calls the Stripe::Refund with correct params' do
      method_call

      expect(::Stripe::Refund)
        .to have_received(:create)
        .with(customer: stripe_customer.id,
              items: [
                price: offer.external_id
              ])
    end
  end
end
