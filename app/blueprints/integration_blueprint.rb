class IntegrationBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :name, :wallet_address, :url, :status, :integration_address

  field(:logo) do |object|
    ImagesHelper.image_url_for(object.logo)
  end
end
