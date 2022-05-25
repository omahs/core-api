require 'rails_helper'

RSpec.describe GivingServices::Fees::Card::StripeCardFeeCalculatorService, type: :service do
  subject(:service) { described_class.new(value: value, currency: currency) }

  describe '#calculate_fee' do
    context 'when the currency is BRL' do
      let(:value) { 100 }
      let(:currency) { 'BRL' }

      it 'calculates the fee correctly' do
        expect(service.calculate_fee).to eq 4.38
      end
    end
  end
end
