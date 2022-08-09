require 'rails_helper'

RSpec.describe Web3::Contracts::BaseContract do
  let(:chain) { Web3::Providers::Networks::MUMBAI }
  let(:arg) { 'arg' }
  let(:function_name) { 'function_name' }
  let(:test_arg) { 'test_arg' }
  let(:client) { instance_double(::Eth::Client) }
  let(:contract) { OpenStruct.new({}) }

  describe '#call' do
    subject(:call) { described_class.new(chain:).call(function_name, arg, test_arg:) }

    before do
      allow(Web3::Providers::Client).to receive(:create).and_return(client)
      allow(::Eth::Contract).to receive(:from_abi).and_return(contract)
      allow(client).to receive_messages(call: {}, max_fee_per_gas: 0, max_priority_fee_per_gas: 0,
                                        gas_limit: 0)
    end

    it 'calls the client with correct args' do
      call

      expect(client).to have_received(:call).with(contract, function_name, arg, test_arg:, gas_limit: 0)
    end
  end

  describe '#transact' do
    subject(:transact) { described_class.new(chain:).transact(function_name, arg, test_arg:) }

    before do
      allow(Web3::Providers::Client).to receive(:create).and_return(client)
      allow(::Eth::Contract).to receive(:from_abi).and_return(contract)
      allow(client).to receive_messages(transact: {}, max_fee_per_gas: 0, max_priority_fee_per_gas: 0,
                                        gas_limit: 0)
    end

    it 'calls the client with correct args' do
      transact

      expect(client).to have_received(:transact).with(contract, function_name, arg, test_arg:, gas_limit: 0)
    end
  end
end
