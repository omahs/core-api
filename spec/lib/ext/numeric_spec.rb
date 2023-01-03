# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Numeric do
  describe '#percent_of(num)' do
    it 'returns the percentage amount of that number related to num' do
      expect(10.percent_of(100)).to eq(10.0)
      expect(10.percent_of(50)).to eq(20.0)
      expect(200.percent_of(100)).to eq(200.0)
      expect(200.percent_of(50)).to eq(400.0)
    end
  end
end
