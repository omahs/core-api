# frozen_string_literal: true

require 'rails_helper'

describe Contributions::HandleContributionFee do
  let(:contribution) { create(:contribution, person_payment: create(:person_payment, liquid_value_cents: 1000)) }
  let(:command) { described_class.new(contribution:) }

  before do
    create(:ribon_config, contribution_fee_percentage: 20)
  end

  describe '#call' do
    subject(:call) { command.call }

    context 'when there are payer contributions with fees balance' do
      let!(:payer1) { create(:contribution, person_payment: create(:person_payment)) }
      let!(:payer2) { create(:contribution, person_payment: create(:person_payment)) }

      before do
        payer1.contribution_balance.update!(fees_balance_cents: 200)
        payer2.contribution_balance.update!(fees_balance_cents: 300)
      end

      it 'creates the correct number of ContributionFees' do
        expect { call }.to change(ContributionFee, :count).by(2)
      end

      it 'spreads the fee to payer contributions' do
        call

        expect(payer1.contribution_balance.reload.fees_balance_cents).to eq(50)
        expect(payer2.contribution_balance.reload.fees_balance_cents).to eq(150)
      end

      it 'creates contribution fees with the correct fee cents and payer contribution' do
        call

        contribution_fees = ContributionFee.all
        expect(contribution_fees.count).to eq(2)

        contribution_fees.each do |contribution_fee|
          expect(contribution_fee.contribution).to eq(contribution)
          expect(contribution_fee.fee_cents).to eq(150)
          expect([payer1.id, payer2.id]).to include(contribution_fee.payer_contribution_id)
        end
      end

      it 'updates the payer contribution balance with the correct fee cents' do
        call

        expect(payer1.contribution_balance.reload.total_fees_increased_cents).to eq(150)
        expect(payer2.contribution_balance.reload.total_fees_increased_cents).to eq(150)
      end
    end

    context 'when there are no payer contributions with fees balance' do
      let!(:payer1) { create(:contribution, person_payment: create(:person_payment)) }
      let!(:payer2) { create(:contribution, person_payment: create(:person_payment)) }

      before do
        payer1.contribution_balance.update!(fees_balance_cents: 0)
        payer2.contribution_balance.update!(fees_balance_cents: 0)
      end

      it 'does not create contribution fees' do
        expect { call }.not_to change(ContributionFee, :count)
      end
    end
  end
end
