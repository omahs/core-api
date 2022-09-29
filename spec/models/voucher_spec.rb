# == Schema Information
#
# Table name: vouchers
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  donation_id    :bigint
#  external_id    :string
#  integration_id :bigint           not null
#
require 'rails_helper'

RSpec.describe Voucher, type: :model do
  describe '.validations' do
    subject { build(:voucher) }

    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id).scoped_to(:integration_id) }
  end
end
