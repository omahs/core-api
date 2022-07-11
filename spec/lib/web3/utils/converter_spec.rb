require 'rails_helper'

RSpec.describe Web3::Utils::Converter do
  describe '.parse_wei' do
    it 'converts from wei to integer' do
      one_wei = 1_000_000_000_000_000_000

      expect(described_class.parse_wei(one_wei)).to eq 1
    end
  end

  describe '.to_wei' do
    it 'converts a value to wei' do
      one_wei = 1_000_000_000_000_000_000

      expect(described_class.to_wei(1)).to eq one_wei
    end
  end

  describe '.keccak' do
    it 'converts a value to it`s keccak' do
      value = 'test'
      keccak_value = '9c22ff5f21f0b81b113e63f7db6da94fedef11b2119b4088b89664fb9a3cb658'

      expect(described_class.keccak(value)).to eq keccak_value
    end
  end
end
