require 'rails_helper'

RSpec.describe IntegrationWallet, type: :model do
  describe '.validations' do
    subject { build(:integration_wallet) }

    it { is_expected.to validate_presence_of(:public_key) }
    it { is_expected.to validate_presence_of(:encrypted_private_key) }
    it { is_expected.to validate_presence_of(:private_key_iv) }
    it { is_expected.to belong_to(:integration) }
  end

  describe '#private_key' do
    let(:private_key_string) { '3ecf3128ad6df6257e693368e8860cd59b5ceee5f6550796efe841d4ccaed1c2' }
    let(:integration_wallet) { build(:integration_wallet) }

    it 'returns the integration private key decoded' do
      expect(integration_wallet.private_key).to eq(private_key_string)
    end
  end
end
