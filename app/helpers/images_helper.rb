# frozen_string_literal: true

module ImagesHelper
  def self.image_url_for(image)
    Rails.application.routes.url_helpers.polymorphic_url(image) if image.attached?
  rescue StandardError
    nil
  end
end
