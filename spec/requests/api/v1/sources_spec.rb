require 'rails_helper'

RSpec.describe 'Api::V1::Sources', type: :request do
  describe 'POST /create' do
    subject(:request) { post '/api/v1/sources', params: }

    context 'with right params' do
      let(:user)        { create(:user)        }
      let(:integration) { create(:integration) }

      let(:params) do
        {
          user_id: user.id,
          integration_id: integration.id
        }
      end

      it 'creates a new user in database' do
        expect { request }.to change(Source, :count).by(1)
      end

      it 'heads http status created' do
        request

        expect(response).to have_http_status :created
      end

      it 'returns the user' do
        request

        expect_response_to_have_keys %w[id user_id integration_id]
      end

      context 'when the user has already a source' do
        before do
          create(:source, user_id: user.id, integration_id: integration.id)
        end

        it 'does not create a new source' do
          expect { request }.not_to change(Source, :count)
        end

        it 'heads http status unprocessable entity' do
          request

          expect(response).to have_http_status :unprocessable_entity
        end

        it 'returns an error message' do
          request

          expect_response_to_have_keys %w[message]
        end
      end
    end

    context 'with wrong params' do
      let(:params) do
        {
          user_id: 'undefined',
          integration_id: nil
        }
      end

      it 'does not create a new user in database' do
        expect { request }.not_to change(Source, :count)
      end

      it 'heads http unprocessable_entity' do
        request

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
