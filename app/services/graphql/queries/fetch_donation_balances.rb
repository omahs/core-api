module Graphql
  module Queries
    module FetchDonationBalances
      Query = Graphql::RibonApi::Client.parse <<-'GRAPHQL'
        query {
          donationBalances {
            id
            integration{
              id
            }
            totalDonated
            nonProfit{
              id
            }
            user
          }
        }
      GRAPHQL
    end
  end
end
