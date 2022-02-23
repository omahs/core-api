require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /create' do
    subject(:request) { post '/api/v1/users', params: params }

    context 'with right params' do
      let(:params) do
        {
          email: 'yan@ribon.io'
        }
      end

      it 'creates a new user in database' do
        expect { request }.to change(User, :count).by(1)
      end

      it 'heads http status created' do
        request

        expect(response).to have_http_status :created
      end

      it 'returns the user' do
        request

        expect_response_to_have_keys %w[created_at id email updated_at]
      end
    end

    context 'with wrong params' do
      let(:params) do
        {
          email: 'invalid_email'
        }
      end

      it 'does not create a new user in database' do
        expect { request }.not_to change(User, :count)
      end

      it 'heads http unprocessable_entity' do
        request

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
