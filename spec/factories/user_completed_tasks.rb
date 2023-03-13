FactoryBot.define do
  factory :user_completed_task do
    task_id { build(:task) }
    user_id { build(:user) }
    completed_at { "2023-03-13 16:55:14" }
    completion_count { 1 }
  end
end
