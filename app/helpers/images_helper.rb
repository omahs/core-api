# frozen_string_literal: true

module ImagesHelper
  def self.image_url_for(image, variant: nil)
    img = variant ? image.variant(variant) : image
    Rails.application.routes.url_helpers.polymorphic_url(img)
  rescue StandardError
    nil
  end
end
