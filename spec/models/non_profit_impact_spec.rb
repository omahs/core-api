require 'rails_helper'

RSpec.describe NonProfitImpact, type: :model do
  describe '.validations' do
    subject { build(:non_profit_impact) }

    it { is_expected.to belong_to(:non_profit) }
    it { is_expected.to validate_presence_of(:usd_cents_to_one_impact_unit) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
  end
end
