require 'rails_helper'

RSpec.describe 'Api::V1::Manager::Authorization', type: :request do
  describe 'POST /create' do
    subject(:request) { post '/api/v1/manager/auth/request', params: }

    context 'with right params' do
      include_context('when mocking a request') { let(:cassette_name) { 'create_google_authorization' } }
      let(:params) do
        {
          data: {
            id_token: 'eyJhbGciOiJSUzI1NiIsIm'
          }
        }
      end

      it 'creates a new user in database' do
        expect { request }.to change(UserManager, :count).by(1)
      end

      it 'heads http status created' do
        request

        expect(response).to have_http_status :created
      end
    end

    context 'with wrong params' do
      include_context('when mocking a request') { let(:cassette_name) { 'create_google_authorization_failed' } }
      let(:params) do
        {
          data: {
            id_token: 'joseph'
          }
        }
      end

      it 'does not create a new user in database' do
        expect { request }.not_to change(UserManager, :count)
      end

      it 'heads http unprocessable_entity' do
        request

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
