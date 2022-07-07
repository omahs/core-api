# frozen_string_literal: true

require 'rails_helper'

describe Givings::Payment::CreateOrder do
  describe '.call' do
    subject(:command) { described_class.call(order_type_class, args) }

    let(:user) { create(:user) }
    let(:customer) { build(:customer) }

    context 'when using a CreditCard payment' do
      let(:order_type_class) { Givings::Payment::OrderTypes::CreditCard }
      let(:card) { build(:credit_card) }
      let(:offer) { create(:offer) }
      let(:customer_payment) { build(:customer_payment, offer:, customer:, amount_cents: 1) }

      let(:args) do
        { card:, email: 'user@test.com', tax_id: '111.111.111-11', offer:,
          payment_method: :credit_card, user:, operation: :subscribe }
      end

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

      it 'calls GivingServices::Payment::Orchestrator process' do
        orchestrator_double = instance_double(GivingServices::Payment::Orchestrator, { call: nil })
        allow(GivingServices::Payment::Orchestrator).to receive(:new).and_return(orchestrator_double)
        command

        expect(orchestrator_double).to have_received(:call)
      end

      context 'when the payment is sucessfull' do
        it 'calls the success callback' do
          allow(Givings::Payment::AddGivingToBlockchainJob).to receive(:perform_later)
          orchestrator_double = instance_double(GivingServices::Payment::Orchestrator, { call: nil })
          allow(GivingServices::Payment::Orchestrator).to receive(:new).and_return(orchestrator_double)
          command

          expect(Givings::Payment::AddGivingToBlockchainJob).to have_received(:perform_later)
            .with(amount: customer_payment.amount, user_identifier: 'user@test.com',
                  payment: an_object_containing(customer_payment.attributes))
        end
      end
    end

    context 'when using a Crypto payment' do
      let(:order_type_class) { Givings::Payment::OrderTypes::Cryptocurrency }
      let(:transaction_hash) { '0xFFFF' }
      let(:customer_payment) { build(:customer_payment, offer: nil, customer:) }

      let(:args) do
        { email: 'user@test.com', payment_method: :crypto,
          user:, amount: '7.00', transaction_hash: }
      end

      context 'when there is no customer associated with the user' do
        it 'creates a new customer to the user' do
          expect { command }.to change(user.customers, :count).by(1)
        end
      end

      it 'creates a CustomerPayment' do
        expect { command }.to change(CustomerPayment, :count).by(1)
      end

      it 'creates a CustomerPaymentBlockChain' do
        expect { command }.to change(CustomerPaymentBlockchain, :count).by(1)
      end
    end
  end
end
