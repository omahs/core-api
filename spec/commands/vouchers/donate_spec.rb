# frozen_string_literal: true

require 'rails_helper'

describe Vouchers::Donate do
  describe '.call' do
    subject(:command) { described_class.call(integration:, donation_command:, external_id:) }

    context 'when no error occurs' do
      let(:donation_command) { Donations::Donate.new(integration:, non_profit:, user:) }
      let(:external_id) { 'external_id' }
      let(:integration) { build(:integration) }
      let(:non_profit) { build(:non_profit) }
      let(:user) { build(:user) }
      let(:donation) { build(:donation) }
      let(:donation_command_double) { command_double(klass: Donations::Donate, result: donation) }

      before do
        allow(donation_command).to receive(:call).and_return(donation_command_double)
        create(:ribon_config, default_ticket_value: 100)
      end

      it 'creates a voucher' do
        expect(command.result).to be_an_instance_of Voucher
      end
    end
  end
end
