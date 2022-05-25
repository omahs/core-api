require 'rails_helper'

RSpec.describe GivingServices::Taxes::Card::StripeCardTaxCalculatorService, type: :service do
  subject(:service) { described_class.new(value: value) }

  describe '#calculate_tax' do
    let(:value) { 100 }

    it 'calculates the tax correctly' do
      expect(service.calculate_tax).to eq 4.38
    end
  end
end
