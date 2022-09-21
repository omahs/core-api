# == Schema Information
#
# Table name: wallets
#
#  id                    :bigint           not null, primary key
#  encrypted_private_key :string
#  owner_type            :string           not null
#  private_key_iv        :string
#  public_key            :string
#  status                :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  owner_id              :bigint           not null
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
