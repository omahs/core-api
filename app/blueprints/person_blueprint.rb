class PersonBlueprint < Blueprinter::Base
  identifier :id

  association :customer, blueprint: CustomerBlueprint
end
