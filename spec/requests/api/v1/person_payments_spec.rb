require 'rails_helper'

RSpec.describe 'Api::V1::PersonPayments', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/person_payments' }

    include_context('when mocking a request') { let(:cassette_name) { 'conversion_rate_brl_usd' } }

    before do
      create_list(:person_payment, 2)
      allow(Currency::Converters).to receive(:convert_to_usd).and_return(1)
    end

    it 'returns a list of person_payments' do
      request

      expect_response_collection_to_have_keys(%w[amount_cents crypto_amount id
                                                 offer page paid_date payment_method
                                                 person status total_items total_pages])
    end
  end
end
