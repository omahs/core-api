class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :email
end
