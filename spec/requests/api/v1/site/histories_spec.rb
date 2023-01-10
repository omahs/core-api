require 'rails_helper'

RSpec.describe 'Api::V1::Site::Histories', type: :request do
  describe 'GET /total_donors' do
    subject(:request) { get '/api/v1/site/total_donors' }

    before do
      create_list(:history, 1)
    end

    it 'returns a list of total donors' do
      request

      expect(response_json.to_json).to eq({ total_donors: History.all.sum(:total_donors) }.to_json)
    end
  end

  describe 'GET /non_profits_total_balance' do
    subject(:request) { get '/api/v1/site/non_profits_total_balance' }

    before do
      allow(Currency::Converters).to receive(:convert_to_usd).and_return(1)
      allow(Currency::Converters).to receive(:convert_to_brl).and_return(1)
      create_list(:history, 1)
      create_list(:donation, 2)
      create_list(:person_payment, 2)
    end

    it 'returns a list of total donations' do
      request

      expect(response_json.to_json).to eq({ non_profits_total_balance: '2.02 USDC' }.to_json)
    end
  end

  describe 'GET /non_profits_total_balance?language=pt-BR' do
    subject(:request) { get '/api/v1/site/non_profits_total_balance?language=pt-BR' }

    before do
      allow(Currency::Converters).to receive(:convert_to_usd).and_return(1)
      allow(Currency::Converters).to receive(:convert_to_brl).and_return(1)
      create_list(:history, 1)
      create_list(:donation, 2)
      create_list(:person_payment, 2)
    end

    it 'returns a list of total donations' do
      request

      expect(response_json.to_json).to eq({ non_profits_total_balance: 'R$ 1032.0' }.to_json)
    end
  end
end
