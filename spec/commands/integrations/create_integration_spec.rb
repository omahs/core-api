# frozen_string_literal: true

require 'rails_helper'

describe Integrations::CreateIntegration do
  describe '.call' do
    subject(:command) { described_class.call(params) }

    context 'when all the data is valid' do
      let(:params) do
        {
          name: 'Integration 1',
          status: :active
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
