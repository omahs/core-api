class SourceBlueprint < Blueprinter::Base
  identifier :id
  association :user, blueprint: UserBlueprint
  association :integration, blueprint: IntegrationBlueprint
end
