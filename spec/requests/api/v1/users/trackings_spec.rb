require 'rails_helper'

RSpec.describe 'Api::V1::Users::Trackings', type: :request do
  describe 'PUT /api/v1/users/track' do
    subject(:request) { get "/api/v1/users/#{user.id}/impacts", headers:, params: }

    let(:user) { create(:user) }
    let(:params) do
      { utm: { source: 'source', medium: 'medium', campaign: 'campaign' } }
    end

    before do
      allow(User).to receive(:find).and_return(user)
    end

    it 'sends the request and returns ok' do
      request

      expect(response).to have_http_status :ok
    end
  end
end
