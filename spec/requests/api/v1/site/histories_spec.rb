require 'rails_helper'

RSpec.describe 'Api::V1::Site::Histories', type: :request do
  describe 'GET /total_donors' do
    subject(:request) { get '/api/v1/site/total_donors' }

    before do
      create_list(:history, 1)
    end

    it 'returns a list of total donors' do
      request

      expect_response_collection_to_have_keys(%w[total_donors])
    end
  end

  describe 'GET /total_donations' do
    subject(:request) { get '/api/v1/site/total_donations' }

    before do
      VCR.insert_cassette 'conversion_rate_usd_brl'
      allow(Currency::Converters).to receive(:convert_to_usd).and_return(1)
      allow(Currency::Converters).to receive(:convert_to_brl).and_return(1)
      create_list(:history, 1)
    end

    it 'returns a list of total donations' do
      request

      expect_response_collection_to_have_keys(%w[total_donations])
    end
  end
end
