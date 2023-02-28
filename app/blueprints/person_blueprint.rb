class PersonBlueprint < Blueprinter::Base
  identifier :id

  association :customer, blueprint: CustomerBlueprint

  association :guest, blueprint: GuestBlueprint
end
