require 'rails_helper'

RSpec.describe Service::Users::Statistics, type: :service do
  subject(:service) { described_class.new(donations:, user:, customer:) }
  
  

  let(:user) { create(:user) }
  let(:person) { create(:person) }
  let(:customer) { create(:customer, user:, email: user.email, person:) }
  let(:donations) { Donation.where(user:) }
  let(:non_profit) { create(:non_profit) }
  let(:non_profit2) { create(:non_profit) }

  before do
    create_list(:donation, 2, value: 10, user:, non_profit:)
    create_list(:donation, 2, value: 10, user:, non_profit: non_profit2)
    create_list(:person_payment, 2, status: :paid, person:,
                                      offer: create(:offer, currency: :usd, price_cents: 1000))

    allow(Currency::Converters).to receive(:convert_to_usd).and_return(1)

    allow(Currency::Converters).to receive(:convert_to_brl).and_return(1)
  end

  describe '#total_causes' do
    it 'returns the total causes count' do
      expect(service.total_causes).to eq 2
    end
  end

  describe '#total_non_profits' do
    it 'returns the total non_profits count' do
      expect(service.total_non_profits).to eq 2
    end
  end

  describe '#total_donated' do
    it 'returns the total donated count' do
      expect(service.total_donated).to eq({brl: 1.0, usd: 21.0})
    end
  end
end
