# frozen_string_literal: true

require 'rails_helper'

describe Integrations::CreateIntegration do
  describe '.call' do
    subject(:command) { described_class.call(params) }

    context 'when all the data is valid' do
      let(:logo) do
        path = Rails.root.join('spec', 'factories', 'images', 'pitagoras.jpg')

        upload = ActiveStorage::Blob.create_and_upload!(io: File.open(path),
                                                        filename: 'pitagoras.jpg',
                                                        content_type: 'image/jpg')

        upload.as_json(root: false, methods: :signed_id)
      end

      let(:params) do
        {
          name: 'Integration 1',
          status: :active,
          logo: logo['signed_id']
        }
      end

      it 'creates a new integration' do
        expect { command }.to change(Integration, :count).by(1)
      end

      it 'creates a new integration wallet' do
        expect { command }.to change(IntegrationWallet, :count).by(1)
      end
    end

    context 'when a data is invalid' do
      let(:params) do
        {
          name: 'Integration 1',
          status: :processing
        }
      end

      it 'does not create a new integration' do
        expect { command }.not_to change(Integration, :count)
      end

      it 'does not create a new integration wallet' do
        expect { command }.not_to change(IntegrationWallet, :count)
      end
    end
  end
end
