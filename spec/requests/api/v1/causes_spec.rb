require 'rails_helper'

RSpec.describe 'Api::V1::Causes', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/causes' }

    before do
      create_list(:cause, 1)
    end

    it 'returns a list of causes' do
      request

      expect_response_collection_to_have_keys(%w[created_at id updated_at name main_image cover_image pools
                                                 active])
    end
  end

  describe 'GET /show' do
    subject(:request) { get "/api/v1/causes/#{cause.id}" }

    let(:cause) { create(:cause) }

    it 'returns a single causes' do
      request

      expect_response_to_have_keys(%w[created_at id updated_at name cover_image main_image pools active])
    end
  end

  describe 'POST /create' do
    subject(:request) { post '/api/v1/causes', params: }

    let(:params) { { name: 'New Cause' } }
    let(:result) { create(:cause) }

    before do
      mock_command(klass: Causes::UpsertCause, result:)
      request
    end

    it 'returns a single causes' do
      cause = request

      expect_response_to_have_keys(%w[created_at id updated_at name cover_image main_image pools])
    end
  end

  describe 'PUT /update' do
    subject(:request) { put "/api/v1/causes/#{cause.id}", params: }

    let(:cause) { create(:cause) }
    let(:params) { { id: cause.id, name: 'New Name' } }

    it 'updates the cause' do
      request

      expect(cause.reload.name).to eq('New Name')
    end
  end
end
