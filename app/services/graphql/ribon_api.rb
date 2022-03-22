require 'graphql/client'
require 'graphql/client/http'

module Graphql
  module RibonApi
    HTTP = GraphQL::Client::HTTP.new(RibonCoreApi.config[:the_graph][:url]) do
      def headers(_context)
        {}
      end
    end

    # Fetch latest schema on init, this will make a network request
    Schema = GraphQL::Client.load_schema(HTTP)

    # However, it's smart to dump this to a JSON file and load from disk
    #
    # Run it from a script or rake task
    #   GraphQL::Client.dump_schema(SWAPI::HTTP, "path/to/schema.json")
    #
    # Schema = GraphQL::Client.load_schema("path/to/schema.json")

    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
  end
end
