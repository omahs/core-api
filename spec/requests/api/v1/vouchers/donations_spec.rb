require 'rails_helper'

RSpec.describe 'Api::V1::Vouchers::Donations', type: :request do
  describe 'POST /create' do
    subject(:request) { post '/api/v1/vouchers/donations', params: }

    let(:integration) { create(:integration) }
    let(:non_profit) { create(:non_profit) }
    let(:user) { create(:user) }
    let(:external_id) { 'external_id' }
    let(:params) do
      {
        integration_id: integration.id,
        non_profit_id: non_profit.id,
        email: user.email,
        external_id:
      }
    end

    before do
      create(:ribon_config)
    end

    context 'when the donate command succeeds' do
      it 'returns the voucher' do
        request

        expect(response_body.voucher.external_id).to eq external_id
      end
    end
  end
end
