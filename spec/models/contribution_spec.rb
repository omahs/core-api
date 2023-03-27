# == Schema Information
#
# Table name: contributions
#
#  id                :bigint           not null, primary key
#  receiver_type     :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  person_payment_id :bigint           not null
#  receiver_id       :bigint           not null
#
require 'rails_helper'

RSpec.describe Contribution, type: :model do
  describe '.validations' do
    subject { build(:contribution) }

    it { is_expected.to belong_to(:person_payment) }
    it { is_expected.to belong_to(:receiver) }
    it { is_expected.to have_one(:contribution_balance) }
  end
end
