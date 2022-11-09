require 'rails_helper'

RSpec.describe Graphql::Queries::FetchPools, type: :service do
  describe '#fetch_pools' do
    let(:fetch_pools) { Graphql::RibonApi::Client.query(Graphql::Queries::FetchPools::Query) }

    it 'returns the pools from the graph url' do
      result = fetch_pools

      expect(result.data.pools.length).to be >= 0
    end
  end
end
