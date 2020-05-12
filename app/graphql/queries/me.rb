module Queries
  class Me < Queries::BaseQuery
    description 'profile of signed user'

    type Types::UserType, null: false

    def resolve
      context[:current_user]
    end
  end
end
