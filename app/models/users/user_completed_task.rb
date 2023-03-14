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
class UserCompletedTask < ApplicationRecord
  belongs_to :task
  belongs_to :user
end
