module Graphql
  module Queries
    module FetchIntegrations
      Query = Graphql::RibonApi::Client.parse <<-'GRAPHQL'
        query {
          integrations {
            id
            balance
          }
        }
      GRAPHQL
    end
  end
end
