require 'rails_helper'

RSpec.describe Service::Donations::Statistics, type: :service do
  subject(:service) { described_class.new(donations:) }

  let(:user) { create(:user) }
  let(:donations) { Donation.all }
  let(:non_profit1) { create(:non_profit) }
  let(:non_profit2) { create(:non_profit) }

  before do
    create(:non_profit_impact, usd_cents_to_one_impact_unit: 10,
                               non_profit: non_profit1, start_date: 1.day.ago, end_date: 1.day.from_now)
    create(:non_profit_impact, usd_cents_to_one_impact_unit: 10,
                               non_profit: non_profit2, start_date: 1.day.ago, end_date: 1.day.from_now)
    create_list(:donation, 2, value: 10, user:, non_profit: non_profit1)
    create(:donation, value: 10, user:, non_profit: non_profit2)
  end

  describe '#total_donations' do
    it 'returns the total donations count' do
      expect(service.total_donations).to eq 3
    end
  end

  describe '#total_donors' do
    it 'returns the total donors count' do
      expect(service.total_donors).to eq 1
    end
  end

  describe '#impact_per_non_profit' do
    it 'returns the impact value per non profit' do
      expect(service.impact_per_non_profit.first[:impact]).to eq 2
      expect(service.impact_per_non_profit.second[:impact]).to eq 1
      expect(service.impact_per_non_profit.first[:non_profit].name).to eq non_profit1.name
      expect(service.impact_per_non_profit.second[:non_profit].name).to eq non_profit2.name
    end
  end
end
