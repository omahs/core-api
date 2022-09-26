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
#  type                  :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  owner_id              :bigint           not null
#
require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe 'if trying to create a wallet without owner' do
    it 'raises error' do
      expect { create(:wallet, owner: nil) }.to raise_error 'Validation failed: Owner must exist'
    end
  end
end
