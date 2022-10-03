class IntegrationTaskBlueprint < Blueprinter::Base
  fields :link, :link_address, :description

  field(:mobility_attributes) do |_object|
    IntegrationTask.mobility_attributes
  end
end
