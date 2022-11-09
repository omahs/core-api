module Graphql
  module Queries
    module FetchPools
      Query = Graphql::RibonApi::Client.parse <<-'GRAPHQL'
        query {
          pools {
            id
            balance
          }
        }
      GRAPHQL
    end
  end
end
