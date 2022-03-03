module Types
  module Input
    class UserInputType < Types::BaseInputObject
      argument :email, String, required: true
      argument :impact, Integer
    end
  end
end