# == Schema Information
#
# Table name: legacy_users
#
#  id         :bigint           not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
require 'rails_helper'

RSpec.describe LegacyUser, type: :model do
  describe '.validations' do
    subject { build(:legacy_user) }

    it { is_expected.to validate_presence_of(:email) }
  end
end
