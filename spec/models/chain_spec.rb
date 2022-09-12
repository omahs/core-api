# == Schema Information
#
# Table name: chains
#
#  id                              :bigint           not null, primary key
#  block_explorer_url              :string
#  currency_name                   :string
#  donation_token_contract_address :string
#  gas_fee_url                     :string
#  name                            :string
#  node_url                        :string
#  ribon_contract_address          :string
#  rpc_url                         :string
#  symbol_name                     :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  chain_id                        :integer
#
require 'rails_helper'

RSpec.describe Chain, type: :model do
  describe '.validations' do
    subject { build(:chain) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:ribon_contract_address) }
    it { is_expected.to validate_presence_of(:donation_token_contract_address) }
    it { is_expected.to validate_presence_of(:chain_id) }
    it { is_expected.to validate_presence_of(:rpc_url) }
    it { is_expected.to validate_presence_of(:node_url) }
    it { is_expected.to validate_presence_of(:symbol_name) }
    it { is_expected.to validate_presence_of(:currency_name) }
    it { is_expected.to validate_presence_of(:block_explorer_url) }
  end

  describe '#gas_fee' do
    subject(:chain) { build(:chain) }

    let(:fee_instance) { instance_double(Web3::Utils::Fee) }

    before do
      allow(Web3::Utils::Fee).to receive(:new).and_return(fee_instance)
      allow(fee_instance).to receive(:estimate_fee)
    end

    it 'calls the Fee lib #calculate_fee' do
      chain.gas_fee

      expect(fee_instance).to have_received(:estimate_fee)
    end
  end
end
