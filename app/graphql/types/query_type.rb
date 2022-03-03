module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"

    field :fetch_users, resolver: Queries::FetchUsers

    field :fetch_user_impact, resolver: Queries::FetchUserImpact

    def test_field
      "Hello World!"
    end
  end
end
