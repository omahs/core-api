# == Schema Information
#
# Table name: user_completed_tasks
#
#  id               :uuid             not null, primary key
#  completed_at     :datetime
#  completion_count :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  task_id          :bigint           not null
#  user_id          :bigint           not null
#
FactoryBot.define do
  factory :user_completed_task do
    task_id { build(:task) }
    user_id { build(:user) }
    completed_at { '2023-03-13 16:55:14' }
    completion_count { 1 }
  end
end
