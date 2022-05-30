require 'rails_helper'

RSpec.describe UserServices::UserImpact, type: :service do
  describe '#impact' do
    let(:user) { build(:user, email: 'user@test.com') }
    let(:non_profit1) do
      create(:non_profit, :with_impact,
             wallet_address: '0xf20c382d2a95eb19f9164435aed59e5c59bc1fd9')
    end
    let(:non_profit2) do
      create(:non_profit, :with_impact,
             wallet_address: '0xg20c382d2a95eb19f9164435aed59e5c59bc1fd9')
    end

    before do
      non_profit1
      non_profit2
      allow(Graphql::RibonApi::Client).to receive(:query).and_return(build(:fetch_donation_balances_query))
    end

    it 'returns the sum of impact' do
      user_impact = user.impact
      expect(user_impact.first[:impact]).to eq 18
      expect(user_impact.last[:impact]).to eq 1
    end

    it 'returns the non profits' do
      user_impact = user.impact
      expect(user_impact.first[:non_profit]).to eq non_profit1
      expect(user_impact.last[:non_profit]).to eq non_profit2
    end
  end
end
