require 'rails_helper'

RSpec.describe Web3::Contracts::RibonContract do
  let(:chain) { build(:chain) }
  let(:client) { instance_double(::Eth::Client) }
  let(:contract) { OpenStruct.new({}) }
  let(:amount) { 0.5 }
  let(:user) { build(:user).email }

  describe '#add_pool_balance' do
    subject(:method_call) do
      described_class.new(chain:).add_pool_balance(donation_pool_address: '0xFFFF', amount:)
    end

    before do
      allow(Web3::Providers::Client).to receive(:create).and_return(client)
      allow(::Eth::Contract).to receive(:from_abi).and_return(contract)
      allow(client).to receive_messages(transact: {}, max_fee_per_gas: 0, max_priority_fee_per_gas: 0,
                                        gas_limit: 0)
    end

    it 'calls the transact with correct args' do
      method_call
      wei_amount = Web3::Utils::Converter.to_decimals(amount, 6)
      sender_key = Web3::Providers::Keys::RIBON_KEY
      donation_pool_address = '0xFFFF'

      expect(client)
        .to have_received(:transact).with(contract, 'addPoolBalance',
                                          donation_pool_address, wei_amount,
                                          gas_limit: 0, sender_key:)
    end
  end

  describe '#add_integration_balance' do
    subject(:method_call) { described_class.new(chain:).add_integration_balance(integration_address:, amount:) }

    let(:integration_address) { build(:integration_wallet).public_key }

    before do
      allow(Web3::Providers::Client).to receive(:create).and_return(client)
      allow(::Eth::Contract).to receive(:from_abi).and_return(contract)
      allow(client).to receive_messages(transact: {}, max_fee_per_gas: 0, max_priority_fee_per_gas: 0,
                                        gas_limit: 0)
    end

    it 'calls the transact with correct args' do
      method_call
      wei_amount = Web3::Utils::Converter.to_wei(amount)
      sender_key = Web3::Providers::Keys::RIBON_KEY

      expect(client)
        .to have_received(:transact).with(contract, 'addIntegrationBalance',
                                          integration_address, wei_amount,
                                          gas_limit: 0, sender_key:)
    end
  end

  describe '#donate_through_integration' do
    subject(:method_call) do
      described_class.new(chain:)
                     .donate_through_integration(donation_pool_address: '0xFFFF', amount:,
                                                 user:, non_profit_wallet_address:, sender_key:)
    end

    let(:non_profit_wallet_address) { build(:non_profit).wallet_address }
    let(:sender_key) { RibonCoreApi.config[:web3][:wallets][:ribon_wallet_private_key] }
    let(:key_struct) { OpenStruct.new({ private_key: sender_key }) }

    before do
      allow(Web3::Providers::Client).to receive(:create).and_return(client)
      allow(::Eth::Contract).to receive(:from_abi).and_return(contract)
      allow(client).to receive_messages(transact: {}, max_fee_per_gas: 0, max_priority_fee_per_gas: 0,
                                        gas_limit: 0)
      allow(::Eth::Key).to receive(:new).and_return(key_struct)
    end

    it 'calls the transact with correct args' do
      method_call
      wei_amount = Web3::Utils::Converter.to_decimals(amount, 6)
      keccak256_user = Web3::Utils::Converter.keccak(user)
      donation_pool_address = '0xFFFF'

      expect(client)
        .to have_received(:transact).with(contract, 'donateThroughIntegration',
                                          donation_pool_address, non_profit_wallet_address,
                                          keccak256_user, wei_amount, gas_limit: 0,
                                                                      sender_key: key_struct)
    end
  end
end
