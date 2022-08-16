require 'rails_helper'

RSpec.describe 'Api::V1::Givings::Impacts', type: :request do
  describe 'POST /impact_by_non_profit' do
    subject(:request) { post '/api/v1/givings/impact_by_non_profit', params: }

    let(:non_profit) { create(:non_profit) }
    let(:params) do
      { value: 50, currency: 'usd', non_profit_id: non_profit.id }
    end
    let(:result) do
      { impact: 10, rounded_impact: 100 }
    end

    before do
      mock_command(klass: Givings::Impact::CalculateImpactToNonProfit, result:)
      request
    end

    it 'calls the CalculateImpactToNonProfit command with correct params' do
      expect(Givings::Impact::CalculateImpactToNonProfit)
        .to have_received(:call).with(value: params[:value].to_f,
                                      currency: params[:currency].downcase.to_sym,
                                      non_profit:)
    end

    it 'returns all the impact information' do
      expect(response_json.keys).to match_array %w[impact rounded_impact]
    end

    it 'returns the command result' do
      expect(response_json.to_json).to eq result.to_json
    end
  end
end
