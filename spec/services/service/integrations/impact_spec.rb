require 'rails_helper'

RSpec.describe Service::Integrations::Impact, type: :service do
  subject(:service) { described_class.new(integration:, start_date:, end_date:) }

  let(:integration) { create(:integration) }
  let(:start_date) { 1.day.ago }
  let(:end_date) { 1.day.from_now }
  let(:user) { create(:user) }

  before do
    create_list(:donation, 3, integration:, created_at: 2.days.ago, value: 5)
    create_list(:donation, 4, integration:, created_at: Time.zone.today, value: 10, user:)
  end

  describe '#total_donations' do
    it 'returns the total donations count' do
      expect(service.total_donations).to eq 4
    end
  end

  describe '#total_donors' do
    it 'returns the total donors count' do
      expect(service.total_donors).to eq 1
    end
  end

  describe '#impact_per_non_profit' do
    let(:non_profit) { create(:non_profit) }

    it 'returns the impact value per non profit' do
      allow(Service::Donations::Statistics)
        .to receive(:new).and_return(
          instance_double(Service::Donations::Statistics, impact_per_non_profit: [{ non_profit:, impact: 10 }])
        )

      expect(service.impact_per_non_profit.first[:impact]).to eq 10
      expect(service.impact_per_non_profit.first[:non_profit].name).to eq non_profit.name
    end
  end
end
