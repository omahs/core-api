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
require 'rails_helper'

RSpec.describe UserCompletedTask, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
