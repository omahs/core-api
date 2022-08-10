require 'rails_helper'

RSpec.describe Integration, type: :model do
  describe '.validations' do
    subject { build(:integration) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:unique_address) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe '#integration_address' do
    let(:integration) { create(:integration) }

    it 'returns the integration address' do
      expect(integration.integration_address).to eq("https://dapp.ribon.io/integration/#{integration.unique_address}")
    end
  end

  describe '#available_everyday_at_midnight?' do
    context 'when ticket_availability_in_minutes is present' do
      let(:integration) { create(:integration, ticket_availability_in_minutes: 10) }

      it 'returns false' do
        expect(integration.available_everyday_at_midnight?).to be_falsey
      end
    end

    context 'when ticket_availability_in_minutes is zero' do
      let(:integration) { create(:integration, ticket_availability_in_minutes: 0) }

      it 'returns false' do
        expect(integration.available_everyday_at_midnight?).to be_falsey
      end
    end

    context 'when ticket_availability_in_minutes is not present' do
      let(:integration) { create(:integration) }

      it 'returns true' do
        expect(integration.available_everyday_at_midnight?).to be_truthy
      end
    end
  end
end
