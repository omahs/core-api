require 'rails_helper'

RSpec.describe 'Integrations', type: :request do
  describe 'GET /integrations/check' do
    context 'when the request has a valid token' do
      subject(:request) { get '/integrations/check', headers: }

      let(:headers) do
        { Authorization: "Bearer #{token}" }
      end
      let(:integration) { create(:integration) }
      let(:token) { 'valid_token' }

      before do
        integration.api_keys.create!(token:)
      end

      it 'returns http status :ok' do
        request

        expect(response).to have_http_status :ok
      end
    end

    context 'when the request has an invalid token' do
      subject(:request) { get '/integrations/check', headers: }

      let(:headers) do
        { Authorization: "Bearer #{token}" }
      end
      let(:integration) { create(:integration) }
      let(:token) { 'invalid_token' }

      it 'returns http status :unauthorized' do
        request

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
