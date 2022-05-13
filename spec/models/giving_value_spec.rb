require 'rails_helper'

RSpec.describe GivingValue, type: :model do
  describe '.validations' do
    subject { build(:giving_value) }

    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:currency) }
  end

  describe '#currency_symbol' do
    context 'when it is usd' do
      it 'returns $' do
        giving_value = build(:giving_value, currency: :usd)

        expect(giving_value.currency_symbol).to eq '$'
      end
    end

    context 'when it is brl' do
      it 'returns R$' do
        giving_value = build(:giving_value, currency: :brl)

        expect(giving_value.currency_symbol).to eq 'R$'
      end
    end
  end
end
