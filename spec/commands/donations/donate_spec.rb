# frozen_string_literal: true

require 'rails_helper'

describe Donations::Donate do
  describe '.call' do
    subject(:command) { described_class.call(integration: integration, non_profit: non_profit, user: user) }

    let(:integration) { build(:integration) }
    let(:non_profit) { build(:non_profit) }
    let(:user) { build(:user) }

    before do
      allow(Donation).to receive(:create!)
      allow(Web3::RibonContract).to receive(:donate_through_integration)
    end

    it 'creates a donation in database' do
      command

      expect(Donation).to have_received(:create!).with(integration: integration, non_profit: non_profit,
                                                       user: user)
    end

    it 'calls the donation in contract' do
      command

      expect(Web3::RibonContract)
        .to have_received(:donate_through_integration)
        .with(amount: Donations::Donate::DEFAULT_DONATION_AMOUNT,
              non_profit: '0x000',
              user: '0x6E060041D62fDd76cF27c582f62983b864878E8F')
    end
  end
end
