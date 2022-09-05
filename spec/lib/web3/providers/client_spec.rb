require 'rails_helper'

RSpec.describe Web3::Providers::Client do
  describe '.create' do
    subject(:method_call) { described_class.create(chain:) }

    let(:chain) { build(:chain) }
    let(:gas_class_instance) { instance_double(Web3::Utils::Gas) }

    before do
      allow(Eth::Client).to receive(:create).and_return(
        OpenStruct.new({ max_fee_per_gas: 0, max_priority_fee_per_gas: 0, gas_limit: 0 })
      )
      allow(Web3::Utils::Gas).to receive(:new).and_return(gas_class_instance)
      allow(gas_class_instance).to receive(:estimate_gas).and_return(
        OpenStruct.new({ max_fee_per_gas: 50, max_priority_fee_per_gas: 50, default_gas_limit: 78_000 })
      )
    end

    it 'calls Eth::Client create with correct param' do
      method_call

      expect(Eth::Client).to have_received(:create).with(chain[:node_url])
    end

    it 'sets the correct fees' do
      client = method_call

      expect(client.max_fee_per_gas).to eq 50 * ::Eth::Unit::GWEI
      expect(client.max_priority_fee_per_gas).to eq 50 * ::Eth::Unit::GWEI
      expect(client.gas_limit).to eq 78_000
    end
  end
end
