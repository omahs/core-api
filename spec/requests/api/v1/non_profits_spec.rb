require 'rails_helper'

RSpec.describe 'Api::V1::NonProfits', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/non_profits' }

    before do
      create_list(:non_profit, 2)
    end

    it 'returns a list of non profits' do
      request

      expect_response_collection_to_have_keys(%w[created_at id impact_description link name updated_at
                                                 wallet_address cover_image background_image logo main_image])
    end
  end
end
