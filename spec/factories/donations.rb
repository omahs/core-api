# == Schema Information
#
# Table name: donations
#
#  id             :bigint           not null, primary key
#  value          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#  non_profit_id  :bigint           not null
#  user_id        :bigint
#
FactoryBot.define do
  factory :donation do
    non_profit { build(:non_profit) }
    integration { build(:integration) }
    user { build(:user) }
  end
end
