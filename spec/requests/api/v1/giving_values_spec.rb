require 'rails_helper'

RSpec.describe 'Api::V1::GivingValues', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/giving_values?currency=usd' }

    before do
      create_list(:giving_value, 2, currency: :usd)
    end

    it 'returns a list of non profits' do
      request

      expect_response_collection_to_have_keys(%w[created_at id updated_at value value_text currency])
    end
  end
end
