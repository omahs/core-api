# frozen_string_literal: true

require 'rails_helper'

describe Configs::UpdateRibonConfig do
  describe '.call' do
    subject(:command) { described_class.call(ribon_config_params) }

    context 'when update with the right params' do
      let(:ribon_config) { create(:ribon_config) }
      let(:ribon_config_params) do
        {
          id: ribon_config.id,
          default_ticket_value: '100.4'
        }
      end

      it 'updates the ribon config with new default ticket value' do
        command
        expect(ribon_config.reload.default_ticket_value).to eq(0.1004e3)
      end
    end
  end
end
