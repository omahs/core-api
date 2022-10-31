require 'rails_helper'

RSpec.describe 'Api::V1::Causes', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/causes' }

    before do
      create_list(:cause, 1)
    end

    it 'returns a list of causes' do
      request

      expect_response_collection_to_have_keys(%w[created_at id updated_at name main_image])
    end
  end
end
