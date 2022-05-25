require 'rails_helper'

RSpec.describe GivingServices::Taxes::TaxCalculatorService, type: :service do
  subject(:service) { described_class.new(value: value, kind: kind) }

  let(:stripe_card_service_class) { GivingServices::Taxes::Card::StripeCardTaxCalculatorService }

  let!(:card_service_instance) do
    mock_instance(klass: stripe_card_service_class,
                  mock_methods: [:calculate_tax])
  end

  describe '#calculate_tax' do
    context 'when it is called with :stripe_card kind' do
      let(:value) { 100 }
      let(:kind) { :stripe_card }

      it 'calls the CardTaxCalculatorService with correct params' do
        service.calculate_tax

        expect(stripe_card_service_class).to have_received(:new).with(value: value)
        expect(card_service_instance).to have_received(:calculate_tax)
      end
    end
  end
end
