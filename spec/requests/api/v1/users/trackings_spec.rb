require 'rails_helper'

RSpec.describe 'Api::V1::Users::Trackings', type: :request do
  describe 'PUT /api/v1/users/track' do
    subject(:send_request) { put "/api/v1/users/#{user.id}/track", headers:, params: }

    context 'when the user is authenticated' do
      let(:user) { create(:user) }
      let(:params) do
        { utm: { source: 'source', medium: 'medium', campaign: 'campaign' } }
      end

      before do
        allow(User).to receive(:find).and_return(user)
        ENV['NOAUTH'] = 'false'
      end

      it 'returns ok' do
        send_request

        expect(response).to have_http_status :ok
      end

      it 'calls the track module' do
        expect_any_instance_of(Api::V1::Users::TrackingsController)
          .to receive(:track).with(trackable: user,
                                   utm_params: { source: 'source', medium: 'medium', campaign: 'campaign' })

        send_request
      end
    end
  end
end
