module Graphql
  module Queries
    module FetchPromoters
      Query = Graphql::RibonApi::Client.parse <<-'GRAPHQL'
        query {
          promoters {
            id
            totalDonated
          }
        }
      GRAPHQL
    end
  end
end