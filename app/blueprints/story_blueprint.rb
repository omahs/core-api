class StoryBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :title, :description

  association :non_profit, blueprint: NonProfitBlueprint, view: :minimal

  field(:image) do |object|
    ImagesHelper.image_url_for(object.image, variant: { resize_to_fit: [600, 600], format: :jpg })
  end

  view :minimal do
    excludes :created_at, :updated_at, :non_profit
  end
end
