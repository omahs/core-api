module Queries
  class FetchUserImpact < Queries::BaseQuery

    type Types::UserImpactType, null: false

    def resolve
      User.first.donations.count
    end
  end
end
