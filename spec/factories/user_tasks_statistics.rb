# == Schema Information
#
# Table name: user_tasks_statistics
#
#  id                        :bigint           not null, primary key
#  first_completed_all_tasks :date
#  streak                    :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  user_id                   :bigint           not null
#
FactoryBot.define do
  factory :user_tasks_statistic do
    user { build(:user) }
    first_completed_all_tasks { "2023-05-05" }
    streak { 1 }
  end
end
