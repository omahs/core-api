# == Schema Information
#
# Table name: causes
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Cause, type: :model do
  describe '.validations' do
    subject { build(:cause) }

    it { is_expected.to validate_presence_of(:name) }
  end

  describe '.associations' do
    subject { build(:cause) }

    it { is_expected.to have_many(:non_profits) }
  end

  describe '#default_pool' do
    subject(:cause) { create(:cause) }

    let!(:chain) { create(:chain) }
    let!(:chain2) { create(:chain) }
    let!(:pool) { create(:pool, cause:, token: create(:token, chain:)) }
    let!(:pool2) { create(:pool, cause:, token: create(:token, chain: chain2)) }

    before do
      create(:ribon_config, default_chain_id: chain.chain_id)
    end

    it 'returns the pool of the default chain' do
      expect(cause.default_pool).to eq pool
    end

    it 'does not return other pools' do
      expect(cause.default_pool).not_to eq pool2
    end
  end
end
