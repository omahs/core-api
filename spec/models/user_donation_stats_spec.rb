require 'rails_helper'

RSpec.describe UserDonationStats, type: :model do
  describe '.validations' do
    subject { build(:user_donation_stats) }

    it { is_expected.to belong_to(:user) }
  end

  describe '#next_donation_at' do
    subject(:user_donation_stats) { build(:user_donation_stats, last_donation_at: last_donation_date) }

    context 'when the last donation is nil' do
      let(:last_donation_date) { nil }

      it 'returns nil' do
        expect(user_donation_stats.next_donation_at).to be_nil
      end
    end

    context 'when there is a last donation' do
      let(:last_donation_date) { DateTime.parse('2021-01-12 10:00:00') }

      it 'returns when the next donation is available based on cooldown and last donation' do
        expect(user_donation_stats.next_donation_at).to eq DateTime.parse('2021-01-13 00:00:00')
      end
    end
  end
end
