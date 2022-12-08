require 'rails_helper'

RSpec.describe Service::Donations::Statistics, type: :service do
  subject(:service) { described_class.new(donations:) }

  let(:donations) { create_list(:donation, 3, value: 10) }

  describe '#total_donations' do
    it 'returns the total donations count' do
      expect(service.total_donations).to eq 3
    end
  end
end
