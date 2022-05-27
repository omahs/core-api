require 'rails_helper'

RSpec.describe Currency::Rates do
  subject(:service) { described_class.new(from: from, to: to) }

  let(:from) { 'USD' }
  let(:to) { 'BRL' }

  let(:response) do
    { 'USDBRL' =>
       { 'code' => 'USD',
         'codein' => 'BRL',
         'name' => 'Dólar Americano/Real Brasileiro',
         'high' => '4.8411',
         'low' => '4.816',
         'varBid' => '0.0114',
         'pctChange' => '0.24',
         'bid' => '4.8374',
         'ask' => '4.8404',
         'timestamp' => '1653566983',
         'create_date' => '2022-05-26 09:09:43' } }
  end

  describe '#rate' do
    it 'gets the conversion rate', :vcr do
      expect(service.rate).to eq '4.7637'
    end
  end
end
