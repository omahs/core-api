class TaskBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :title, :actions, :rules
end
