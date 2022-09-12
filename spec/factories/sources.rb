# == Schema Information
#
# Table name: sources
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint
#  user_id        :bigint
#
FactoryBot.define do
  factory :source do
    user { build(:user) }
    integration { build(:integration) }
  end
end
