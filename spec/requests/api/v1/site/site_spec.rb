require 'rails_helper'

RSpec.describe 'Api::V1::Site::Site', type: :request do
  describe 'GET /non_profits' do
    subject(:request) { get '/api/v1/site/non_profits' }

    before do
      create_list(:non_profit, 4)
    end

    it 'returns a list of non profits' do
      request

      expect_response_collection_to_have_keys(%w[description name main_image])
    end

    it 'returns 3 last non profits' do
      request

      expect(response_json.count).to eq(3)
    end
  end

    describe 'GET /total_impacted_lives' do
    subject(:request) { get '/api/v1/site/total_impacted_lives' }
    let(:total_impacted_lives) {{total_impacted_lives: "470.770"}}

    it 'returns a mocked data' do
      request

      expect(response_json.to_json).to eq(total_impacted_lives.to_json)
    end
  end
end
