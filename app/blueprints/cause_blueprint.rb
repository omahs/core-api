class CauseBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :name

  view :minimal do
    excludes :created_at, :updated_at
  end
end
