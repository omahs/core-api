class NonProfitBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :name, :wallet_address, :impact_description

  association :cause, blueprint: CauseBlueprint, view: :minimal

  field(:logo) do |object|
    ImagesHelper.image_url_for(object.logo)
  end

  field(:main_image) do |object|
    ImagesHelper.image_url_for(object.main_image)
  end

  field(:background_image) do |object|
    ImagesHelper.image_url_for(object.background_image)
  end

  field(:impact_by_ticket) do |object|
    object.impact_by_ticket
  end
end
