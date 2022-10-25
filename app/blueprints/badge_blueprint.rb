class BadgeBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :category, :description, :name

  field(:image) do |object|
    ImagesHelper.image_url_for(object.image)
  end
end
