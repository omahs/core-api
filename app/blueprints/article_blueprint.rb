class ArticleBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :title, :published_at, :visible

  field(:image_url) do |object|
    ImagesHelper.image_url_for(object.image)
  end

  association :author, blueprint: AuthorBlueprint, view: :minimal
end
