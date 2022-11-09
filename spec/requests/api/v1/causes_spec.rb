require 'rails_helper'

RSpec.describe 'Api::V1::Causes', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/causes' }

    before do
      create_list(:cause, 1)
    end

    it 'returns a list of causes' do
      request

      expect_response_collection_to_have_keys(%w[created_at id updated_at name main_image cover_image pools
                                                 active])
    end
  end

  describe 'GET /show' do
    subject(:request) { get "/api/v1/causes/#{cause.id}" }

    let(:cause) { create(:cause) }

    it 'returns a single causes' do
      request

      expect_response_to_have_keys(%w[created_at id updated_at name cover_image main_image pools active])
    end
  end

  describe '#active' do
    context 'when the non_profits is empty' do
      let(:cause) { create(:cause, non_profits: []) }

      it 'returns false' do
        expect(cause.active).to be_falsey
      end
    end

    context 'when the cause has non_profits but its inactive' do
      let(:cause) { create(:cause, non_profits: [create(:non_profit, status: :inactive)]) }

      it 'returns false' do
        expect(cause.active).to be_falsey
      end
    end

    context 'when the cause has active non_profits associated' do
      let(:cause) { create(:cause, non_profits: [create(:non_profit, status: :active)]) }

      it 'returns false' do
        expect(cause.active).to be_truthy
      end
    end
  end
end
