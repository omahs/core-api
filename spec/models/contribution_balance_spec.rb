# == Schema Information
#
# Table name: contribution_balances
#
#  id                         :bigint           not null, primary key
#  fees_balance_cents         :integer
#  tickets_balance_cents      :integer
#  total_fees_increased_cents :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  contribution_id            :bigint           not null
#
require 'rails_helper'

RSpec.describe ContributionBalance, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:contribution) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:tickets_balance_cents) }
    it { is_expected.to validate_presence_of(:fees_balance_cents) }
    it { is_expected.to validate_presence_of(:total_fees_increased_cents) }
  end
end
