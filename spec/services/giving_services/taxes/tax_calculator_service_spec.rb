require 'rails_helper'

RSpec.describe GivingServices::Taxes::TaxCalculatorService, type: :service do
  subject(:service) { described_class.new(value: value, kind: kind) }

  let(:card_service_class) { GivingServices::Taxes::CardTaxCalculatorService }
  let(:crypto_service_class) { GivingServices::Taxes::CryptoTaxCalculatorService }

  let!(:card_calculator_tax_service_instance) do
    mock_instance(klass: card_service_class,
                  mock_methods: [:calculate_tax])
  end
  let!(:crypto_calculator_tax_service_instance) do
    mock_instance(klass: crypto_service_class,
                  mock_methods: [:calculate_tax])
  end

  describe '#calculate_tax' do
    context 'when it is called with :card kind' do
      let(:value) { 100 }
      let(:kind) { :card }

      it 'calls the CardTaxCalculatorService with correct params' do
        service.calculate_tax

        expect(card_service_class).to have_received(:new).with(value: value)
        expect(card_calculator_tax_service_instance).to have_received(:calculate_tax)
      end
    end

    context 'when it is called with :crypto kind' do
      let(:value) { 100 }
      let(:kind) { :crypto }

      it 'calls the CardTaxCalculatorService with correct params' do
        service.calculate_tax

        expect(crypto_service_class).to have_received(:new).with(value: value)
        expect(crypto_calculator_tax_service_instance).to have_received(:calculate_tax)
      end
    end
  end
end
