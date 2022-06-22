require 'rails_helper'

RSpec.describe GivingServices::Payment::Orchestrator, type: :service do
  subject(:service_call) { described_class.new(payload:).call }

  describe '#call' do
    let(:credit_card) { build(:credit_card) }
    let(:customer_payment) { build(:customer_payment) }
    let(:payload) { Order.from(customer_payment, credit_card, operation) }

    let(:gateway) { Payment::Gateways::Stripe }
    let!(:gateway_instance) do
      mock_instance(klass: gateway::PaymentProcessor, mock_methods: %i[purchase subscribe unsubscribe])
    end

    context 'when the Orchestrator is instanced' do
      let(:operation) { :purchase }
      let!(:factory_instance) do
        mock_instance(klass: GivingServices::Payment::GatewayFactory, mock_methods: [:call])
      end

      it 'calls GatewayFactory and returns a gateway module' do
        expect(factory_instance).to have_received(:call).and_return(gateway)

        service_call
      end
    end

    context 'when is a purchase operation' do
      let(:operation) { :purchase }

      it 'calls PaymentProcessor#purchase method' do
        expect(gateway_instance).to have_received(operation)

        service_call
      end
    end

    context 'when is a subscribe operation' do
      let(:operation) { :subscribe }

      it 'calls PaymentProcessor#subscribe method' do
        expect(gateway_instance).to have_received(operation)

        service_call
      end
    end

    context 'when is a unsubscribe operation' do
      let(:operation) { :unsubscribe }

      it 'calls PaymentProcessor#unsubscribe method' do
        expect(gateway_instance).to have_received(operation)

        service_call
      end
    end
  end
end
