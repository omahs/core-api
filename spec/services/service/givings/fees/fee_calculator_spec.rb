require 'rails_helper'

RSpec.describe Service::Givings::Fees::FeeCalculator, type: :service do
  subject(:service) { described_class.new(value:, kind:, currency:) }

  let(:stripe_card_service_class) { Service::Givings::Fees::Card::StripeCardFeeCalculator }

  let!(:card_service_instance) do
    mock_instance(klass: stripe_card_service_class,
                  mock_methods: [:calculate_fee])
  end

  describe '#calculate_fee' do
    context 'when it is called with :stripe_card kind' do
      let(:value) { 100 }
      let(:kind) { :stripe }
      let(:currency) { 'BRL' }

      it 'calls the CardFeeCalculatorService with correct params' do
        service.calculate_fee

        expect(stripe_card_service_class).to have_received(:new).with(value:, currency:)
        expect(card_service_instance).to have_received(:calculate_fee)
      end
    end
  end
end
