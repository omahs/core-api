class NonProfitBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :name, :wallet_address, :impact_description, :status

  association :cause, blueprint: CauseBlueprint, view: :minimal

  field(:logo) do |object|
    ImagesHelper.image_url_for(object.logo, variant: { resize_to_fit: [150, 150],
                                                       saver: { quality: 95 }, format: :jpg })
  end

  field(:main_image) do |object|
    ImagesHelper.image_url_for(object.main_image, variant: { resize_to_fit: [450, 450],
                                                             saver: { quality: 95 }, format: :jpg })
  end

  field(:background_image) do |object|
    ImagesHelper.image_url_for(object.background_image)
  end

  field(:impact_by_ticket) do |object|
    object.impact_by_ticket
  end
end
