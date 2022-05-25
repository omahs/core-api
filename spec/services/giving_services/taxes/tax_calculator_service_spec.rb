require 'rails_helper'

RSpec.describe GivingServices::Taxes::TaxCalculatorService, type: :service do
  subject(:service) { described_class.new(value: value, kind: kind) }

  let(:card_calculator_tax_service_instance) do
    instance_double(GivingServices::Taxes::CardTaxCalculatorService)
  end
  let(:crypto_calculator_tax_service_instance) do
    instance_double(GivingServices::Taxes::CryptoTaxCalculatorService)
  end

  before do
    allow(GivingServices::Taxes::CardTaxCalculatorService)
      .to receive(:new).and_return(card_calculator_tax_service_instance)
    allow(GivingServices::Taxes::CryptoTaxCalculatorService)
      .to receive(:new).and_return(crypto_calculator_tax_service_instance)
    allow(card_calculator_tax_service_instance).to receive(:calculate_tax)
    allow(crypto_calculator_tax_service_instance).to receive(:calculate_tax)
  end

  describe '#calculate_tax' do
    context 'when it is called with :card kind' do
      let(:value) { 100 }
      let(:kind) { :card }

      it 'calls the CardTaxCalculatorService with correct params' do
        service.calculate_tax

        expect(card_calculator_tax_service_instance).to have_received(:calculate_tax)
      end
    end
  end
end
