# == Schema Information
#
# Table name: new_integration_wallets
#
#  id                    :uuid             not null, primary key
#  encrypted_private_key :string
#  private_key_iv        :string
#  public_key            :string
#  integration_id        :bigint
#
require 'rails_helper'

RSpec.describe NewIntegrationWallet, type: :model do
  describe '.validations' do
    subject { build(:new_integration_wallet) }

    it { is_expected.to validate_presence_of(:public_key) }
    it { is_expected.to validate_presence_of(:encrypted_private_key) }
    it { is_expected.to validate_presence_of(:private_key_iv) }
  end

  describe '#private_key' do
    let(:private_key_string) { '0000000000000000000000000000000000000000000000000000000000000000' }
    let(:new_integration_wallet) { build(:new_integration_wallet) }

    it 'returns the integration private key decoded' do
      expect(new_integration_wallet.private_key).to eq(private_key_string)
    end
  end
end
