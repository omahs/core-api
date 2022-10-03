class IntegrationTaskBlueprint < Blueprinter::Base
  fields :link, :link_address, :description

  field(:mobility_attributes) do |object|
    IntegrationTask.mobility_attributes
  end
end
