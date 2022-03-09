require 'rails_helper'

RSpec.describe UserDonationStats, type: :model do
  describe '.validations' do
    subject { build(:user_donation_stats) }

    it { is_expected.to belong_to(:user) }
  end
end
