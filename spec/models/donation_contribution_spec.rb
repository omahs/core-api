# == Schema Information
#
# Table name: donation_contributions
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  contribution_id :bigint           not null
#  donation_id     :bigint           not null
#
require 'rails_helper'

RSpec.describe DonationContribution, type: :model do
  describe '.validations' do
    subject { build(:donation_contribution) }

    it { is_expected.to belong_to(:donation) }
    it { is_expected.to belong_to(:contribution) }
  end
end
