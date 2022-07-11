require 'rails_helper'

RSpec.describe Web3::Contracts::RibonContract do
  let(:network) { Web3::Providers::Networks::MUMBAI }
  let(:client) { instance_double(::Eth::Client) }
  let(:contract) { OpenStruct.new({}) }
  let(:amount) { 0.5 }
  let(:user) { build(:user).email }

  describe '#add_donation_pool_balance' do
    subject(:method_call) { described_class.new(network:).add_donation_pool_balance(amount:) }

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
        .to have_received(:transact).with(contract, 'addDonationPoolBalance',
                                          wei_amount, gas_limit: 0, sender_key:)
    end
  end

  describe '#donate_through_integration' do
    subject(:method_call) do
      described_class.new(network:)
                     .donate_through_integration(amount:, user:, non_profit_wallet_address:)
    end

    let(:non_profit_wallet_address) { build(:non_profit).wallet_address }

    before do
      allow(Web3::Providers::Client).to receive(:create).and_return(client)
      allow(::Eth::Contract).to receive(:from_abi).and_return(contract)
      allow(client).to receive_messages(transact: {}, max_fee_per_gas: 0, max_priority_fee_per_gas: 0,
                                        gas_limit: 0)
    end

    it 'calls the transact with correct args' do
      method_call
      wei_amount = Web3::Utils::Converter.to_wei(amount)
      keccak256_user = Web3::Utils::Converter.keccak(user)
      sender_key = Web3::Providers::Keys::RIBON_KEY

      expect(client)
        .to have_received(:transact).with(contract, 'donateThroughIntegration',
                                          non_profit_wallet_address, keccak256_user,
                                          wei_amount, gas_limit: 0, sender_key:)
    end
  end
end
