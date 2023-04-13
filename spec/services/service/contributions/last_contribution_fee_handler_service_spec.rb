# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::Contributions::LastContributionFeeHandlerService, type: :service do
  let(:accumulated_fees_result) { 200 }
  let(:contribution_balance) { create(:contribution_balance, fees_balance_cents: 100) }
  let(:contribution) { create(:contribution, generated_fee_cents: 500, usd_value_cents: 1000) }

  subject do
    described_class.new(
      accumulated_fees_result: accumulated_fees_result,
      contribution_balance: contribution_balance,
      contribution: contribution
    )
  end

  describe '#charge_remaining_fee' do
    before { allow_any_instance_of(Service::Contributions::RemainingContributionFeeHandlerService).to receive(:spread_remaining_fee) }

    it 'creates a contribution fee with the correct parameters' do
      expect_any_instance_of(Service::Contributions::ContributionFeeCreatorService).to receive(:handle_fee_creation).with(
        contribution_balance: contribution_balance,
        fee_cents: 100,
        contribution_increased_amount_cents: 200
      )
      subject.charge_remaining_fee
    end

    context 'when accumulated_fees_result is greater than fees_balance_cents' do
      let(:accumulated_fees_result) { 500 }

      it 'calls RemainingContributionFeeHandlerService to spread the remaining fee' do
        expect_any_instance_of(Service::Contributions::RemainingContributionFeeHandlerService).to receive(:spread_remaining_fee)
        subject.charge_remaining_fee
      end
    end
  end
end
