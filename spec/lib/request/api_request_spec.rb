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

  describe '#post' do
    subject(:request) { described_class.post(url, body:, headers:) }

    let(:url) { 'http://test.url' }
    let(:response_json) do
      {
        some_key: 'value'
      }
    end
    let(:body) do
      { body_key: 'body value' }
    end
    let(:headers) do
      { some_header: 'some header' }
    end
    let(:default_headers) do
      { 'Content-Type' => 'application/json' }
    end

    before do
      allow(HTTParty).to receive(:post).and_return(response_json)
    end

    it 'calls httparty with post method and correct params' do
      request

      expect(HTTParty).to have_received(:post).with(url, body:, headers: default_headers.merge(headers))
    end

    it 'formats the request as an openstruct' do
      expect(request.some_key).to eq 'value'
    end
  end
end
