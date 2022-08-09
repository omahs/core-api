require 'rails_helper'

RSpec.describe Web3::Providers::Client do
  describe '.create' do
    subject(:method_call) { described_class.create(chain:) }

    let(:chain) { Web3::Providers::Networks::MUMBAI }

    before do
      allow(Eth::Client).to receive(:create).and_return(
        OpenStruct.new({ max_fee_per_gas: 0,
                         max_priority_fee_per_gas: 0,
                         gas_limit: 0 })
      )
    end

    it 'calls Eth::Client create with correct param' do
      method_call

      expect(Eth::Client).to have_received(:create).with(chain[:node_url])
    end

    it 'sets the correct fees' do
      client = method_call

      expect(client.max_fee_per_gas).to eq described_class::DEFAULT_MAX_FEE_PER_GAS
      expect(client.max_priority_fee_per_gas).to eq described_class::DEFAULT_MAX_FEE_PER_GAS
      expect(client.gas_limit).to eq described_class::DEFAULT_GAS_LIMIT
    end
  end
end
