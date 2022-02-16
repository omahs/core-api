# frozen_string_literal: true

require 'rails_helper'

describe Donations::Donate do
  describe '.call' do
    subject(:command) { described_class.call(integration: integration, non_profit: non_profit) }

    let(:integration) { build(:integration) }
    let(:non_profit) { build(:non_profit) }

    before do
      allow(Donation).to receive(:create!)
    end

    it 'creates a donation in database' do
      command

      expect(Donation).to have_received(:create!).with(integration: integration, non_profit: non_profit)
    end
  end
end
