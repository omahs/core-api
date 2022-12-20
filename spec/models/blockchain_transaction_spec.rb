# == Schema Information
#
# Table name: blockchain_transactions
#
#  id               :bigint           not null, primary key
#  owner_type       :string           not null
#  status           :integer          default("processing")
#  transaction_hash :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  chain_id         :bigint           not null
#  owner_id         :bigint           not null
#
require 'rails_helper'

RSpec.describe BlockchainTransaction, type: :model do
  describe '.validations' do
    subject { build(:blockchain_transaction) }

    it { is_expected.to validate_presence_of(:transaction_hash) }
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to belong_to(:chain) }
  end

  describe '#transaction_link' do
    subject(:blockchain_transaction) do
      build(:blockchain_transaction,
            chain:, transaction_hash:)
    end

    let(:chain) { build(:chain) }
    let(:transaction_hash) { '0xFF20' }

    it 'the transaction link based on the network and transaction hash' do
      expect(blockchain_transaction.transaction_link)
        .to eq "#{chain.block_explorer_url}tx/#{transaction_hash}"
    end
  end
end
