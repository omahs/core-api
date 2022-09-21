require 'rails_helper'

RSpec.describe 'Integrations::V1::Donations', type: :request do
  describe 'GET /index' do
    include_context('when making an integration request') do
      let(:request) { get '/integrations/v1/donations', headers: }
    end

    let!(:donation) { create(:donation, integration:) }

    it 'returns the donations for the integration' do
      request

      expect(response_body.length).to eq 1
      expect(response_body.first.id).to eq donation.id
    end
  end

  describe 'GET /show' do
    include_context('when making an integration request') do
      let(:request) { get "/integrations/v1/donations/#{donation.id}", headers: }
    end

    context 'when the donation belongs to the integration' do
      let(:donation) { create(:donation, integration:) }

      it 'returns the donation for the integration' do
        request

        expect(response_body.id).to eq donation.id
      end
    end

    context 'when the donation does not belong to the integration' do
      let(:donation) { create(:donation) }

      it 'returns not found' do
        request

        expect(response).to have_http_status :not_found
      end
    end
  end
end
