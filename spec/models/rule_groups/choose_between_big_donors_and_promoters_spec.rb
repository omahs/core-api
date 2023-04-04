require 'rails_helper'

RSpec.describe ChooseBetweenBigDonorsAndPromoters, type: :model do
  include ActiveStorage::Blob::Analyzable

  let(:big_donor) { create(:big_donor) }
  let(:customer) { create(:customer) }
  let(:big_donor_person_payment) { create(:person_payment, payer: big_donor) }
  let(:customer_person_payment) { create(:person_payment, payer: customer) }
  let!(:contribution_from_big_donors) { create_list(:contribution, 2, :with_contribution_balance, person_payment: big_donor_person_payment) }
  let!(:contributions_from_promoters) { create_list(:contribution, 2, :with_contribution_balance, person_payment: customer_person_payment) }
  let(:donation) { create(:donation) }

  subject { described_class.new(donation) }

  describe "#call" do
    let(:chosen_contributions) { Contribution.from_big_donors }
    let(:response) { subject.call({ chosen: chosen_contributions, found: false }) }

    before do
      create(:ribon_config, default_ticket_value: 100, contribution_fee_percentage: 100)
    end

    context "when there are no promoters contributions" do
      it "returns big donors response" do
        expect(response[:chosen].pluck(:id)).to eq(chosen_contributions.pluck(:id))
      end
    end

    context "when there are no big donors contributions" do
      let(:chosen_contributions) { Contribution.from_unique_donors }
      let(:response) { subject.call({ chosen: chosen_contributions, found: false }) }

      it "returns promoters response" do
        expect(response[:chosen].pluck(:id)).to eq(chosen_contributions.pluck(:id))
      end
    end

    context "when there are both big donors and promoters contributions" do
      let(:chosen_contributions) { Contribution.all }
      let(:response) { subject.call({ chosen: chosen_contributions, found: false }) }

      it "chooses between big donors and promoters based on the calculated percentage" do
        byebug
        allow(subject).to receive(:rand).and_return(0.3)
        expect(response[:chosen].pluck(:id)).to eq(contributions_from_promoters.pluck(:id))

        allow(subject).to receive(:rand).and_return(0.8)
        expect(response[:chosen].pluck(:id)).to eq(contributions_from_big_donors.pluck(:id))
      end
    end
  end
end
