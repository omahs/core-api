require 'rails_helper'

RSpec.describe 'BigDonors', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/big_donors' }

    before do
      create_list(:big_donor, 1)
    end

    it 'returns http success' do
      request

      expect(response).to have_http_status(:success)
      expect_response_collection_to_have_keys(%w[id name email])
    end
  end

  describe 'POST /create' do
    subject(:request) { post '/api/v1/big_donors', params: }

    context 'with the right params' do
      let(:params) { { name: 'New big donor', email: 'bigdonor@gmail.com' } }
      let(:result) { create(:big_donor) }

      before do
        mock_command(klass: BigDonors::CreateBigDonor, result:)
      end

      it 'calls the create command with right params' do
        request

        expect(BigDonors::CreateBigDonor).to have_received(:call).with(strong_params(params))
      end

      it 'returns a single donor' do
        request

        expect_response_to_have_keys(%w[id name email])
      end
    end

    context 'with the wrong params' do
      let(:params) { { name: '' } }

      it 'renders a error message' do
        request
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
