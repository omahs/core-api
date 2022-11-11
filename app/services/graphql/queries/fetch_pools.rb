module Graphql
  module Queries
    module FetchPools
      Query = Graphql::RibonApi::Client.parse <<-'GRAPHQL'
        query {
          pools(orderBy: timestamp, orderDirection: asc) {
            id
            timestamp
          }
        }
      GRAPHQL
    end
  end
end
