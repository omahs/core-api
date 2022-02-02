require 'rails_helper'

RSpec.describe NonProfit, type: :model do
  describe '.validations' do
    subject { build(:non_profit) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:wallet_address) }
    it { is_expected.to validate_presence_of(:impact_description) }
  end
end
