module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"

    field :all_users, [UserType], null: false

    def test_field
      "Hello World"
    end

    def all_users
      User.all
    end
  end
end
