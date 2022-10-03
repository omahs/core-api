require 'rails_helper'

RSpec.describe 'Api::V1::NonProfits', type: :request do
  describe 'GET /index with 2 non profits available' do
    subject(:request) { get '/api/v1/non_profits' }

    before do
      create_list(:non_profit, 2)
    end

    it 'returns a list of non profits' do
      request

      expect_response_collection_to_have_keys(%w[created_at id impact_description name updated_at
                                                 wallet_address cover_image background_image logo main_image
                                                 impact_by_ticket cause])
    end

    it 'returns 2 non profits' do
      request

      expect(response_json.count).to eq(2)
    end
  end

  describe 'GET /index with 1 non profit available' do
    subject(:request) { get '/api/v1/non_profits' }

    before do
      create(:non_profit)
      create_list(:non_profit, 2, status: :inactive)
    end

    it 'returns 1 non profits' do
      request

      expect(response_json.count).to eq(1)
    end
  end
end
