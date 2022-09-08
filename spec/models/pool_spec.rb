require 'rails_helper'

RSpec.describe Pool, type: :model do
  describe '.validations' do
    subject { build(:pool) }

    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to belong_to(:token) }
    it { is_expected.to belong_to(:integration) }
  end

  describe '#chain' do
    subject(:pool) { build(:pool) }

    it 'returns the chain of the token' do
      expect(pool.chain).to eq(pool.token.chain)
    end
  end
end
