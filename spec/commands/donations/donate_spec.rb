# frozen_string_literal: true

require 'rails_helper'

describe Donations::Donate do
  describe '.call' do
    subject(:command) { described_class.call(integration: integration, non_profit: non_profit, user: user) }

    let(:integration) { build(:integration) }
    let(:non_profit) { build(:non_profit) }
    let(:user) { build(:user) }
    let(:donation) { build(:donation, created_at: DateTime.parse('2021-01-12 10:00:00')) }

    before do
      allow(Donation).to receive(:create!).and_return(donation)
      allow(Web3::RibonContract).to receive(:donate_through_integration).and_return(
        { 'body' => {
          transaction_hash: '0x00'
        }.to_json }
      )
      allow(Donations::SetUserLastDonationAt)
        .to receive(:call)
        .and_return(command_double(klass: Donations::SetUserLastDonationAt))
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
              non_profit_address: non_profit.wallet_address,
              user_email: user.email)
    end

    it 'calls the Donations::SetUserLastDonationAt' do
      command

      expect(Donations::SetUserLastDonationAt)
        .to have_received(:call).with(user: user, date_to_set: donation.created_at)
    end
  end
end
