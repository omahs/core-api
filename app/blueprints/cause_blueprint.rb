class CauseBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :name

  field(:main_image) do |object|
    ImagesHelper.image_url_for(object.main_image)
  end

  view :minimal do
    excludes :created_at, :updated_at
  end
end
