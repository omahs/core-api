require 'rails_helper'

RSpec.describe UserQueries, type: :model do
  describe '#last_contribution' do
    let(:user) { create(:user) }
    let(:person) { create(:person, customer:) }
    let(:customer) { create(:customer, user:) }
    let(:last_contribution) { create(:person_payment, person:, paid_date: Time.zone.now) }

    before do
      create_list(:person_payment, 2, person:, paid_date: 1.day.ago)
      last_contribution
    end

    it 'returns the last contribution of the user' do
      expect(described_class.new(user:).last_contribution).to eq(last_contribution)
    end
  end

  describe '.users_that_last_contributed_in' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:person) { create(:person, customer:) }
    let(:person2) { create(:person, customer: customer2) }
    let(:customer) { create(:customer, user:) }
    let(:customer2) { create(:customer, user: user2) }

    before do
      create_list(:person_payment, 2, person:, paid_date: 1.day.ago)
      create_list(:person_payment, 2, person: person2, paid_date: 5.days.ago)
    end

    it 'returns only the users that contributed lastly in the passed date' do
      expect(described_class.users_that_last_contributed_in(1.day.ago)).to eq([user])
    end
  end
end
