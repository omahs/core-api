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

  describe '#ticket_availability' do
    context 'when ticket_availability_in_minutes is present' do
      let(:integration) { create(:integration, ticket_availability_in_minutes: 10) }

      it 'returns the ticket availability in minutes' do
        expect(integration.ticket_availability).to eq('10 minutes')
      end
    end

    context 'when ticket_availability_in_minutes is not present' do
      let(:integration) { create(:integration) }

      it 'returns the ticket availability in minutes' do
        expect(integration.ticket_availability).to eq('Everyday at midnight')
      end
    end
  end

  describe '#daily_availability?' do
    context 'when ticket_availability_in_minutes is present' do
      let(:integration) { create(:integration, ticket_availability_in_minutes: 10) }

      it 'returns false' do
        expect(integration.daily_availability?).to be_falsey
      end
    end

    context 'when ticket_availability_in_minutes is not present' do
      let(:integration) { create(:integration) }

      it 'returns true' do
        expect(integration.daily_availability?).to be_truthy
      end
    end
  end
end
