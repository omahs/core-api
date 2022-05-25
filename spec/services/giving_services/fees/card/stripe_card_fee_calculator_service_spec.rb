require 'rails_helper'

RSpec.describe GivingServices::Fees::Card::StripeCardFeeCalculatorService, type: :service do
  subject(:service) { described_class.new(value: value) }

  describe '#calculate_fee' do
    let(:value) { 100 }

    it 'calculates the fee correctly' do
      expect(service.calculate_fee).to eq 4.38
    end
  end
end
