require 'rails_helper'

RSpec.describe 'Api::V1::Users::Impacts', type: :request do
  subject(:request) { get "/api/v1/users/#{user.id}/impacts" }

  describe 'GET /index' do
    let(:user) { create(:user) }
    let(:non_profit) { build(:non_profit) }

    before do
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:impact).and_return([{
                                                   non_profit: non_profit,
                                                   impact: 5
                                                 }])
    end

    it 'returns the user impact by ngo' do
      request

      expect(response_json.first.keys).to match_array %w[impact non_profit]
    end
  end
end
