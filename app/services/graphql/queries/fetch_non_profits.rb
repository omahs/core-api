module Graphql
  module Queries
    module FetchNonProfits
      Query = Graphql::RibonApi::Client.parse <<-'GRAPHQL'
        query {
          nonProfits {
            id
            isNonProfitOnWhitelist
          }
        }
      GRAPHQL
    end
  end
end
