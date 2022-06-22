# frozen_string_literal: true

require 'rails_helper'

describe Givings::Payment::CreateOrder do
  describe '.call' do
    subject(:command) { described_class.call(args) }

    let(:args) do
      { card:, email: 'user@test.com', tax_id: '111.111.111-11', offer_id: offer.id,
        payment_method: :credit_card, user:, operation: :subscribe }
    end
    let(:card) { build(:credit_card) }
    let(:user) { create(:user) }
    let(:offer) { create(:offer) }
    let(:customer) { build(:customer) }
    let(:customer_payment) { build(:customer_payment, offer:, customer:) }

    context 'when there is no customer associated with the user' do
      it 'creates a new customer to the user' do
        expect { command }.to change(user.customers, :count).by(1)
      end
    end

    it 'creates a CustomerPayment' do
      expect { command }.to change(CustomerPayment, :count).by(1)
    end

    it 'calls GivingServices::Payment::Orchestrator with correct payload' do
      allow(GivingServices::Payment::Orchestrator).to receive(:new)
      allow(Customer).to receive(:create!).and_return(customer)
      allow(CustomerPayment).to receive(:create!).and_return(customer_payment)
      command

      expect(GivingServices::Payment::Orchestrator)
        .to have_received(:new).with(payload: an_object_containing(
          payment_method: 'credit_card', payment: customer_payment,
          status: :paid, card:, offer:, customer:
        ))
    end
  end
end
