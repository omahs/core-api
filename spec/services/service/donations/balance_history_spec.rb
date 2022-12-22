require 'rails_helper'

RSpec.describe Service::Donations::BalanceHistory, type: :service do
  include ActiveStorage::Blob::Analyzable
  subject(:service) { described_class.new(pool:) }

  let(:chain) { create(:chain) }
  let(:token) { create(:token, chain:) }
  let(:cause) { create(:cause) }
  let(:non_profit) { create(:non_profit, cause:) }
  let(:pool) { create(:pool, cause:, token:, address: "0xa932851982118bd5fa99e16b144afe4622eb2a49") }
  let(:donations) { create_list(:donation, 3, non_profit:, created_at: Time.zone.yesterday) }
  let(:person_payment) { create(:person_payment,receiver: non_profit, status: :paid, created_at: Time.zone.yesterday) }
  let(:fetch_pools) { OpenStruct.new(
    {"data"=>  OpenStruct.new(                                                                                        
      {"pools"=>                                                                                        
        [OpenStruct.new({"id"=>"0xa932851982118bd5fa99e16b144afe4622eb2a49", "balance"=>"5290000000003440061", "timestamp"=>"1662990753"})]
        })
      }
      )}
      
  describe '#add_balance' do
    before do
      create(:ribon_config, default_ticket_value: 100, default_chain_id: chain.chain_id)
      allow(Graphql::RibonApi::Client).to receive(:query).and_return(fetch_pools)
      @balance_history = service.add_balance
    end

    it 'creates a balance history for a certain pool' do
      expect(BalanceHistory.count).to eq 1
    end

    it 'returns the cause of the pool' do
      expect(@balance_history.cause).to eq cause
    end

    it 'date should be today' do
      expect(@balance_history.date).to eq Time.zone.today
    end

    it 'returns the balance of the pool' do
      expect(@balance_history.balance).to eq 5290000000003440061
    end

    it 'returns the total amount donated of the pool' do
      expect(@balance_history.amount_donated).to eq donations.map{ |x| x.value }.sum

    end
  end
end
