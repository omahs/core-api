class CustomerBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :customer_keys
end
