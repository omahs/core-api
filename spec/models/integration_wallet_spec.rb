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
    # rubocop:disable Layout/LineLength
    let(:private_key) { "\x84\xA9\xC3\x8F\xC9+\xA6\xDBQ\xB0\xC7=\x82\xD2\xA9-%\xAC\xF9\x95xr\x92+\x99w\x0F\x1C\x18\xF0\xBC\x1D\xF1\xC6bD\x17y\xFDr\xFF1\xF7\xBD\xBF\x16;\";t.Z$ \x7F\xAACR\x1A\x981\x1E&\td\xC4_\xC6\xD9\xBB)\xFBW\xB8\x06\xA6{\xC0#\xE4" }
    # rubocop:enable Layout/LineLength
    let(:private_key_iv) { ")B\x82\x06\x89\xEB\x87`+;\xCD\xCD\xF5]J\xBF" }
    let(:encrypted_private_key) { Base64.strict_encode64(private_key) }
    let(:encrypted_private_key_iv) { Base64.strict_encode64(private_key_iv) }

    let(:integration_wallet) do
      build(:integration_wallet,
            encrypted_private_key:,
            private_key_iv: encrypted_private_key_iv)
    end

    it 'returns the integration private key decoded' do
      expect(integration_wallet.private_key).to eq(private_key_string)
    end
  end
end
