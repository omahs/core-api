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
end
