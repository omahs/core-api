class ArticleBlueprint < Blueprinter::Base
  include ActionView::Helpers::DateHelper

  identifier :id

  fields :updated_at, :created_at, :title, :published_at, :visible, :link

  field(:image_url) do |object|
    ImagesHelper.image_url_for(object.image)
  end

  field(:published_at_in_words) do |object|
    Formatters::Date.in_words_for(object.published_at)
  end

  association :author, blueprint: AuthorBlueprint, view: :minimal
end
