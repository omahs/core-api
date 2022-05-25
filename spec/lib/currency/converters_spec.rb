require 'rails_helper'

RSpec.describe Currency::Converters do
  subject(:service) { described_class.new(value: value, from: from, to: to) }

  let(:value) { 10 }
  let(:from) { 'USD' }
  let(:to) { 'BRL' }
  let(:rate) { 5 }

  before do
    allow(Currency::Rates).to receive(:new).and_return(OpenStruct.new({ rate: 5 }))
  end

  describe '#convert' do
    it 'converts from usd to brl' do
      expect(service.convert.to_f).to eq 50
    end
  end
end
