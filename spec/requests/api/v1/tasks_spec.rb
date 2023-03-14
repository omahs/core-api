require 'rails_helper'

RSpec.describe 'Api::V1::Tasks', type: :request do
  describe 'GET /index' do
    subject(:request) { get '/api/v1/tasks' }

    before do
      create_list(:task, 1)
    end

    it 'returns a list of tasks' do
      request

      expect_response_collection_to_have_keys(%w[created_at id updated_at title actions rules])
    end
  end

  describe 'GET /show' do
    subject(:request) { get "/api/v1/tasks/#{task.id}" }

    let(:task) { create(:task) }

    it 'returns a single tasks' do
      request

      expect_response_to_have_keys(%w[created_at id updated_at title actions rules])
    end
  end
end
