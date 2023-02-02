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

      expect_response_collection_to_have_keys(%w[amount_cents crypto_amount external_id id
                                                 offer page paid_date payment_method
                                                 person status total_items total_pages])
    end
  end

  describe 'GET /find_by_person' do
    subject(:request) { get "/api/v1/person_payments/#{unique_identifier}" }

    include_context('when mocking a request') { let(:cassette_name) { 'conversion_rate_brl_usd' } }

    before(:each) do
      create_list(:person_payment, 4, person:)
      allow(Currency::Converters).to receive(:convert_to_usd).and_return(1)
    end
    
    context 'when person is a customer' do
      let(:email) { 'dummyemail@ribon.io' }
      let(:unique_identifier) { Base64.strict_encode64(email) }
      let(:customer) { create(:customer, email:) }
      let(:person) { customer.person }

      it 'returns a list of person_payments' do
        request
  
        expect(response_json.count).to eq(4)
  
        expect_response_collection_to_have_keys(%w[amount_cents crypto_amount external_id id
                                                   offer page paid_date payment_method
                                                   person status total_items total_pages])
      end
    end

    context 'when person is a customer' do
      let(:wallet_address) { '0xA222222222222222222222222222222222222222' }
      let(:unique_identifier) { Base64.strict_encode64(wallet_address) }
      let(:guest) { create(:guest, wallet_address:) }
      let(:person) { guest.person }

      it 'returns a list of person_payments' do
        request
  
        expect(response_json.count).to eq(4)
  
        expect_response_collection_to_have_keys(%w[amount_cents crypto_amount external_id id
                                                   offer page paid_date payment_method
                                                   person status total_items total_pages])
      end
    end
  end
end
