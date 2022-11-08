# == Schema Information
#
# Table name: utms
#
#  id             :bigint           not null, primary key
#  campaign       :string
#  medium         :string
#  source         :string
#  trackable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  trackable_id   :bigint
#
require 'rails_helper'

RSpec.describe Utm, type: :model do
  describe '.validations' do
    subject { build(:utm) }

    it { is_expected.to validate_presence_of(:source) }
  end
end
