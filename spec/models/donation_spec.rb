# == Schema Information
#
# Table name: donations
#
#  id             :bigint           not null, primary key
#  value          :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#  non_profit_id  :bigint           not null
#  user_id        :bigint
#
require 'rails_helper'

RSpec.describe Donation, type: :model do
  describe '.validations' do
    subject { build(:donation) }

    it { is_expected.to belong_to(:non_profit) }
    it { is_expected.to belong_to(:integration) }
    it { is_expected.to belong_to(:user) }
  end

  describe '#impact_value' do
    let(:non_profit) { create(:non_profit, :with_impact) }
    let(:donation) { build(:donation, non_profit:, value: 100) }

    it 'returns the impact that one donation has according to the non profit' do
      expect(donation.impact_value).to eq 10
    end
  end

  describe '#impact' do
    let(:non_profit) { create(:non_profit, :with_impact, impact_description: 'impacts') }
    let(:donation) { build(:donation, non_profit:, value: 100) }

    it 'returns the impact value with the non profit impact description' do
      expect(donation.impact).to eq '10 impacts'
    end
  end
end
