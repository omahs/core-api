class IntegrationBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :name, :unique_address, :status, :integration_address,
         :ticket_availability_in_minutes

  field(:logo) do |object|
    ImagesHelper.image_url_for(object.logo)
  end

  association :integration_wallet, blueprint: IntegrationWalletBlueprint

  association :integration_tasks, blueprint: IntegrationTaskBlueprint
end
