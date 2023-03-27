# == Schema Information
#
# Table name: user_completed_tasks
#
#  id                :uuid             not null, primary key
#  last_completed_at :datetime         not null
#  task_identifier   :string           not null
#  times_completed   :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
class UserCompletedTask < ApplicationRecord
  belongs_to :user
end
