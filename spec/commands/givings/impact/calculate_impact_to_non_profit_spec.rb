# frozen_string_literal: true

require 'rails_helper'

describe Givings::Impact::CalculateImpactToNonProfit do
  subject(:command) { described_class.call(non_profit:, value:, currency:) }

  describe '.call' do
    let(:value) { 10 }
    let(:non_profit) { create(:non_profit) }
    let(:currency) { :usd }

    it 'returns the impact and rounded impact' do
      expect(command.result).to eq({ impact: 100, rounded_impact: 100 })
    end
  end
end
