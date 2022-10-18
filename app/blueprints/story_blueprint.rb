class StoryBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :title, :description

  association :non_profit, blueprint: NonProfitBlueprint, view: :minimal

  field(:image) do |object|
    ImagesHelper.image_url_for(object.image)
  end
end
