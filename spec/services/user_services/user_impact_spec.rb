require 'rails_helper'

RSpec.describe UserServices::UserImpact, type: :service do
  describe '#impact' do
    let(:user) { create(:user, email: 'user@test.com') }
    let(:non_profit1) do
      create(:non_profit, :with_impact, wallet_address: '0xA000000000000000000000000000000000000000')
    end
    let(:non_profit2) do
      create(:non_profit, :with_impact, wallet_address: '0xA111111111111111111111111111111111111111')
    end
    let(:integration) { create(:integration) }

    before do
      create_list(:donation, 5, user:, value: 10, non_profit: non_profit1, integration:)
      create_list(:donation, 3, user:, value: 10, non_profit: non_profit2, integration:)
    end

    it 'returns the sum of impact of each non profit' do
      user_impact = user.impact

      expect(user_impact).to match_array [{ impact: 5, non_profit: non_profit1 },
                                          { impact: 3, non_profit: non_profit2 }]
    end
  end
end
