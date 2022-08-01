# frozen_string_literal: true

require 'rails_helper'

describe Integrations::CreateIntegration do
  describe '.call' do
    subject(:command) { described_class.call(name:, status:) }

    context 'when all the data is valid' do
      let(:name) { 'Ribon' }
      let(:status) { :active }

      let(:private_hex) { '8a0be99dddd9d9deb64b4bf795338566652565270c19549488f252b095257dea' }
      let(:address) { OpenStruct.new({ address: '0xc2da3e828d8bb76df7f47a9c20318eae0d1d6e58' }) }

      before do
        mock_instance(klass: Eth::Key, methods: { address:,  private_hex:})
      end

      it 'creates a new integration' do
        expect { command }.to change(Integration, :count).by(1)
      end

      it 'creates a new integration wallet' do
        expect { command }.to change(IntegrationWallet, :count).by(1)
      end
    end

    context 'when a data is invalid' do
      let(:name) { 'Ribon' }
      let(:status) { :undefined }

      it 'raises an error' do
        expect(command.errors).to eq({ message: ["'undefined' is not a valid status"] })
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
