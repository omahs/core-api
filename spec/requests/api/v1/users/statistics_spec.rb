require 'rails_helper'

RSpec.describe 'Api::V1::Users::Statistics', type: :request do
  describe 'GET /index' do
    subject(:request) { get "/api/v1/users/statistics?id#{user.id}&wallet_address=#{wallet_address}" }

    let(:wallet_address) { '0x44d5e936dad202ec600b6a6a5' }
    let(:guest) { create(:guest) }
    let(:user) { build(:user) }
    let(:person) { create(:person) }
    let(:customer) { create(:customer, user:, email: user.email, person:) }
    let(:donations) { Donation.where(user:) }
    let(:result) { { total_causes: 0, total_tickets: 0, total_donated: {brl: 0, usd: 0}, total_non_profits: 0 } }

    before do
      mock_command(klass: Users::CalculateStatistics, result:)
    end

    it 'returns the user statistics' do
      request

      expect_response_to_have_keys(%w[total_causes total_tickets total_donated total_non_profits])
    end
  end
end
