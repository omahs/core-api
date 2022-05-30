require 'rails_helper'

RSpec.describe Request::ApiRequest do
  describe '#get' do
    subject(:request) { described_class.get(url) }

    let(:url) { 'http://test.url' }
    let(:response_json) do
      {
        some_key: 'value'
      }
    end

    before do
      allow(HTTParty).to receive(:get).and_return(response_json)
    end

    it 'calls httparty with get method and correct params' do
      request

      expect(HTTParty).to have_received(:get).with(url)
    end

    it 'formats the request as an openstruct' do
      expect(request.some_key).to eq 'value'
    end
  end
end
