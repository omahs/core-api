require "rails_helper"

RSpec.describe Payment::Stripe::Entities::Customer do
  describe '#create' do
    subject(:customer_creation_call) { described_class.create(customer: customer,
                                                      payment_method: payment_method) }

    let(:customer) { create(:customer) }
    let(:payment_method) { OpenStruct.new({id: 'pay_123'}) }

    before do
      allow(::Stripe::Customer).to receive(:create)
    end

    it 'calls the Stripe::Customer with correct params' do
      customer_creation_call

      expect(::Stripe::Customer)
        .to have_received(:create)
        .with(
          email: customer.email,
          name: customer.name,
          payment_method: payment_method.id,
          invoice_settings: {
            default_payment_method: payment_method.id
          }
        )
    end
  end
end
