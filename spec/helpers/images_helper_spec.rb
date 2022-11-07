# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagesHelper do
  describe '.image_url_for' do
    before do
      allow(Rails.application.routes.url_helpers).to receive(:polymorphic_url)
    end

    let(:image) { build(:story, :with_image).image }

    context 'when a variant is passed' do
      let(:variant) do
        { resize_to_fit: [500, 500], format: :jpg }
      end

      it 'calls the Rails polymorphic url with correct params' do
        allow(image).to receive(:variant).and_return(image)
        described_class.image_url_for(image, variant:)

        expect(image).to have_received(:variant).with(variant)
        expect(Rails.application.routes.url_helpers)
          .to have_received(:polymorphic_url).with(image)
      end
    end

    context 'when no variant is passed' do
      it 'calls the Rails polymorphic url with correct params' do
        described_class.image_url_for(image)

        expect(Rails.application.routes.url_helpers)
          .to have_received(:polymorphic_url).with(image)
      end
    end
  end
end
