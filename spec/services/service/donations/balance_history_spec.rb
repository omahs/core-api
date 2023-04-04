require 'rails_helper'

RSpec.describe Service::Donations::BalanceHistory, type: :service do
  include ActiveStorage::Blob::Analyzable
  subject(:service) { described_class.new(pool:) }

  include_context('when mocking a request') { let(:cassette_name) { 'conversion_rate_brl_usd' } }

  describe '#add_balance' do
    let(:chain) { create(:chain) }
    let(:token) { create(:token, chain:, decimals: 6) }
    let(:cause) { create(:cause) }
    let(:non_profit) { create(:non_profit, cause_id: cause.id) }
    let(:pool) { create(:pool, cause:, token:, address: '0xa932851982118bd5fa99e16b144afe4622eb2a49') }
    let(:cause2) { create(:cause) }
    let(:non_profit2) { create(:non_profit, cause_id: cause2.id) }

    before do
      VCR.insert_cassette('polygon_scan', allow_playback_repeats: true)
      create(:ribon_config, default_ticket_value: 100, default_chain_id: chain.chain_id)
    end

    after do
      VCR.eject_cassette
    end

    it 'creates a balance history for a certain pool' do
      service.add_balance
      expect(BalanceHistory.count).to eq 1
    end

    it 'returns the cause of the pool' do
      balance_history = service.add_balance
      expect(balance_history.cause).to eq cause
    end

    it 'returns the balance of the pool' do
      balance_history = service.add_balance
      expect(balance_history.balance).to eq 95.15
    end

    it 'returns the total amount donated of the pool' do
      non_profit = create(:non_profit, cause_id: cause.id)
      donations = create_list(:donation, 3, non_profit_id: non_profit.id, created_at: Time.zone.yesterday)
      create_list(:donation, 3, non_profit_id: non_profit2.id,
                                created_at: Time.zone.yesterday)
      balance_history = service.add_balance
      expect(balance_history.amount_donated).to eq((donations.sum(&:value).to_f / 100))
    end
  end
end
