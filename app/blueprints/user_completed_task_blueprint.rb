class UserCompletedTaskBlueprint < Blueprinter::Base
  identifier :id

  fields :last_completed_at, :task_identifier, :times_completed
end
