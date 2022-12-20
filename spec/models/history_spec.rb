# == Schema Information
#
# Table name: histories
#
#  id              :bigint           not null, primary key
#  total_donations :bigint
#  total_donors    :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe History, type: :model do
  describe '.validations' do
    subject { build(:history) }

    it { is_expected.to validate_presence_of(:total_donations) }
    it { is_expected.to validate_presence_of(:total_donors) }
  end
end
