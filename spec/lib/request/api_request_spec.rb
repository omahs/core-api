require 'rails_helper'

RSpec.describe Request::ApiRequest do
  describe '#get' do
    subject(:request) { described_class.get(url) }

    let(:url) { 'http://test.url' }

    before do
      allow(HTTParty).to receive(:get)
    end

    it 'calls httparty with get method and correct params' do
      request

      expect(HTTParty).to have_received(:get).with(url)
    end
  end
end
