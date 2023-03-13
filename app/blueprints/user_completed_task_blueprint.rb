class UserCompletedTaskBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id, :task_id, :completed_at, :completion_count
end
