require 'rails_helper'

RSpec.describe "Api::V1::News", type: :request do
  describe 'GET /index with 2 news available' do
    subject(:request) { get '/api/v1/news' }

    before do
      create_list(:news, 2, visible: true)
    end

    it 'returns a list of news' do
      request

      expect_response_collection_to_have_keys(%w[author image_url created_at id published_at title updated_at visible])
    end

    it 'returns 2 news' do
      request

      expect(response_json.count).to eq(2)
    end
  end

  describe 'GET /index with 1 news available' do
    subject(:request) { get '/api/v1/news' }

    before do
      create(:news, visible: true)
      create_list(:news, 2, visible: false)
    end

    it 'returns 1 news' do
      request

      expect(response_json.count).to eq(1)
    end
  end

  describe 'GET /index with 2 hidden news' do
    subject(:request) { get '/api/v1/news?show_hidden_news=true' }

    before do
      create_list(:news, 2, visible: false)
    end

    it 'returns 2 news' do
      request

      expect(response_json.count).to eq(2)
    end
  end

  describe 'GET /index with an 8 items pagination' do
    subject(:request) { get '/api/v1/news?page=1&per=8' }

    before do
      create_list(:news, 10, visible: true)
    end

    it 'returns 8 news' do
      request

      expect(response_json.count).to eq(8)
    end
  end

  describe 'GET /show' do
    subject(:request) { get "/api/v1/news/#{news.id}" }

    let(:news) { create(:news, visible: true) }

    it 'returns a news' do
      request

      expect_response_to_have_keys(%w[author image_url created_at id published_at title updated_at visible])
    end
  end

  describe 'POST /create' do
    subject(:request) { post '/api/v1/news', params: news_params }

    let(:news_params) do
      {
        title: 'New News',
        published_at: Time.now,
        visible: true,
        author_id: create(:author).id
      }
    end

    it 'creates a new news' do
      request

      expect(News.count).to eq(1)
    end
  end

  describe 'PUT /update' do
    subject(:request) { put "/api/v1/news/#{news.id}", params: news_params }

    let(:news) { create(:news) }
    let(:news_params) do
      {
        title: 'New News',
        published_at: Time.now,
        visible: true,
        author_id: create(:author).id
      }
    end

    it 'updates a news' do
      request

      expect(News.count).to eq(1)
      expect(News.first.title).to eq('New News')
    end
  end
end
