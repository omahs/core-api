module Graphql
  module Queries
    module FetchDonationBalances
      Query = Graphql::RibonApi::Client.parse <<-'GRAPHQL'
        query {
          donationBalances {
            id
            integration
            totalDonated
            nonProfit
            user
          }
        }
      GRAPHQL
    end
  end
end
