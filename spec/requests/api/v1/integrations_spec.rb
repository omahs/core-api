require 'rails_helper'

RSpec.describe 'Api::V1::Integrations', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/integrations' }

    before do
      create_list(:integration, 2)
    end

    it 'returns a list of integrations' do
      request

      expect_response_collection_to_have_keys(%w[created_at id updated_at logo name url wallet_address status
                                                 integration_address])
    end
  end

  describe 'GET /show' do
    subject(:request) { get "/api/v1/integrations/#{integration.id}" }

    let(:integration) { create(:integration) }

    it 'returns a single integration' do
      request

      expect_response_to_have_keys(%w[created_at id updated_at logo name url wallet_address status
                                      integration_address])
    end
  end

  describe 'PUT /update' do
    subject(:request) { put "/api/v1/integrations/#{integration.id}", params: }

    let(:integration) { create(:integration) }
    let(:params) { { name: 'New Name' } }

    it 'updates the integration' do
      request

      expect(integration.reload.name).to eq('New Name')
    end
  end
end
