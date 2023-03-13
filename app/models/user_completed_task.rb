class UserCompletedTask < ApplicationRecord
  belongs_to :task_id
  belongs_to :user_id
end
