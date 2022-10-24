# frozen_string_literal: true

require 'rails_helper'

describe Givings::Payment::CreditCardRefund do
  describe '.call' do
    subject(:command) { described_class.call(args) }

    let(:person) { create(:person) }

    context 'when using a CreditCard payment and refund' do
      let(:offer) { create(:offer) }
      let(:integration) { create(:integration) }
      let(:person_payment) { build(:person_payment, offer:, person:, amount_cents: 1) }
      let(:args) { { external_id: 'pi_123' } }

      before do
        allow(PersonPayment).to receive(:find_by).and_return(person_payment)
      end

      it 'calls Service::Givings::Payment::Orchestrator with correct payload' do
        allow(Service::Givings::Payment::Orchestrator).to receive(:new)
        command

        expect(Service::Givings::Payment::Orchestrator)
          .to have_received(:new).with(payload: an_object_containing(
            external_id: person_payment.external_id, gateway: 'stripe',
            operation: 'refund'
          ))
      end

      it 'calls Service::Givings::Payment::Orchestrator process' do
        orchestrator_double = instance_double(Service::Givings::Payment::Orchestrator, { call: nil })
        allow(Service::Givings::Payment::Orchestrator).to receive(:new).and_return(orchestrator_double)
        command

        expect(orchestrator_double).to have_received(:call)
      end

      context 'when the refund is sucessfull' do
        it 'update the status and external_id of person_payment' do
          expect(person_payment.status).to eq('refunded')
        end
      end
    end
  end
end
