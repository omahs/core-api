require 'rails_helper'

RSpec.describe Integration, type: :model do
  describe '.validations' do
    subject { build(:integration) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:unique_address) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe '.find_by_id_or_unique_address' do
    let!(:integration) { create(:integration, id: 1, unique_address: 'f7be8d80-2406-4cb0-82eb-849346d327c9') }

    context 'when the argument is an uuid' do
      it 'finds the integration by its uuid' do
        expect(described_class.find_by_id_or_unique_address 'f7be8d80-2406-4cb0-82eb-849346d327c9')
          .to match an_object_containing(integration.attributes)
      end
    end

    context 'when the argument is an id' do
      it 'finds the integration by its id' do
        expect(described_class.find_by_id_or_unique_address 1)
          .to match an_object_containing(integration.attributes)
      end
    end
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
