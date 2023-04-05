require 'rails_helper'

RSpec.describe Service::Contributions::TicketLabelingService, type: :service do
  subject(:service) { described_class.new(donation:) }

  let(:cause) { create(:cause) }
  let(:non_profit) { create(:non_profit, cause:) }
  let(:donation) { create(:donation, non_profit:) }

  before do
    create(:ribon_config, contribution_fee_percentage: 20, minimum_contribution_chargeable_fee_cents: 10)
  end

  describe '#label_donation' do
    context 'when there are contributions with less than 10% of initial balance' do
      let(:contribution_with_less_than_10_percent) do
        create(:contribution, :with_contribution_balance,
               receiver: cause,
               person_payment: create(:person_payment, payer: create(:big_donor), crypto_value_cents: 1_000_000),
               contribution_balance: create(:contribution_balance, tickets_balance_cents: 100_000))
      end

      before do
        customer_contribution = create(:contribution,
                                       receiver: cause,
                                       person_payment: create(:person_payment, payer: create(:customer)))
        contribution_with_less_than_10_percent
        create_list(:contribution, 2, :with_contribution_balance,
                    receiver: cause,
                    person_payment: create(:person_payment, payer: create(:big_donor)))
        create(:donation_contribution, contribution: customer_contribution)
      end

      it 'labels a donation with the contributions below 10% of tickets balance' do
        expect(service.label_donation).to eq(contribution_with_less_than_10_percent)
      end
    end
  end
end
