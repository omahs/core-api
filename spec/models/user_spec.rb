require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.validations' do
    subject { build(:user) }

    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to have_many(:donations) }
  end

  describe '.create' do
    it 'creates a user_donation_stats' do
      user = described_class.create!(email: 'user@test.com')

      expect(user.user_donation_stats).not_to be_nil
    end
  end
end
