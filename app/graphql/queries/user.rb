
module Queries
  class User < Queries::BaseQuery
    description 'Find a user by ID'

    argument :id, ID, required: true

    type Types::UserType, null: false

    def resolve(id:)
      ::User.find(id)
    end
  end
end
