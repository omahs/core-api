# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  address    :string
#  owner_type :string           not null
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe '.validations' do
    subject { build(:wallet) }

    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'if trying to create a wallet without owner' do
    it 'raises error' do
      expect { create(:wallet, owner: nil) }.to raise_error 'Validation failed: Owner must exist'
    end
  end
end
