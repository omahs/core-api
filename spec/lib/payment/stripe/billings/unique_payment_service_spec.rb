require "rails_helper"

RSpec.describe Payment::Stripe::Billings::UniquePaymentService do
  describe '#call' do
    subject(:service_call) { described_class.new.call(payment_method: payment_method,
                                            customer: customer, amount: amount, currency: currency) }

    let(:amount) { 10 }
    let(:currency) { :usd }
    let(:customer) { instance_double(::Stripe::Customer) }
    let(:payment_method) { instance_double(::Stripe::PaymentMethod) }

    before do
      allow(::Stripe::PaymentIntent).to receive(:create)
    end

    it 'calls the Stripe::PaymentIntent with correct params' do
      service_call
      amount_cents = amount * 100

      expect(::Stripe::PaymentIntent)
        .to have_received(:create)
        .with(payment_method: payment_method,
              customer: customer, amount: amount_cents ,
              currency: currency, confirm: true)
    end
  end
end
