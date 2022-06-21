require 'rails_helper'

RSpec.describe 'Mains', type: :request do
  describe 'GET /health' do
    subject(:request) { get '/health' }

    context 'when everything is ok' do
      it 'returns http status :ok' do
        request

        expect(response).to have_http_status :ok
      end
    end

    context 'when the database is off' do
      it 'returns http status :unprocessable_entity' do
        allow(NonProfit).to receive(:first).and_throw
        request

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
