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
end
