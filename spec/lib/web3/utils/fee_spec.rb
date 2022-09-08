require 'rails_helper'

RSpec.describe Web3::Utils::Fee do
  describe '#estimate_fee' do
    subject(:fee_lib) { described_class.new(chain:, currency: :usd) }

    let(:chain) { build(:chain) }
    let(:mock_response) do
      OpenStruct.new(
        { 'timestamp' => '2022-09-05T11:17:05.689Z',
          'baseFee' => 1.5701499999999995e-07,
          'lastBlock' => 32_719_610,
          'avgTime' => 2.0854271356783918,
          'avgTx' => 148.37,
          'avgGas' => 173_187.72480296827,
          'speeds' =>
         [{ 'acceptance' => 0.35, 'maxFeePerGas' => max_fee_per_gas,
            'maxPriorityFeePerGas' => max_priority_fee_per_gas, 'estimatedFee' => estimated_fee },
          { 'acceptance' => 0.6, 'maxFeePerGas' => max_fee_per_gas,
            'maxPriorityFeePerGas' => max_priority_fee_per_gas, 'estimatedFee' => estimated_fee },
          { 'acceptance' => 1, 'maxFeePerGas' => max_fee_per_gas,
            'maxPriorityFeePerGas' => max_priority_fee_per_gas, 'estimatedFee' => estimated_fee },
          { 'acceptance' => 1, 'maxFeePerGas' => max_fee_per_gas,
            'maxPriorityFeePerGas' => max_priority_fee_per_gas, 'estimatedFee' => estimated_fee }] }
      )
    end
    let(:max_fee_per_gas) { 50 }
    let(:max_priority_fee_per_gas) { 50 }

    before do
      allow(Request::ApiRequest).to receive(:get).and_return(mock_response)
    end

    context 'when the amount is less than 1 usd cent' do
      let(:estimated_fee) { 0.008015313398343337 }

      it 'returns the estimated fee as 1 cent' do
        expect(fee_lib.estimate_fee).to eq Money.from_cents(1, :usd)
      end
    end

    context 'when the amount is more than 1 usd cent' do
      let(:estimated_fee) { 0.028015313398343337 }

      it 'returns the estimated fee rounded up' do
        expect(fee_lib.estimate_fee).to eq Money.from_cents(3, :usd)
      end
    end
  end
end
