require 'rails_helper'

RSpec.describe 'BigDonors', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/big_donors' }

    before do
      create_list(:big_donor, 1)
    end

    it 'returns http success' do
      request

      expect(response).to have_http_status(:success)
      expect_response_collection_to_have_keys(%w[id name email])
    end
  end
end
