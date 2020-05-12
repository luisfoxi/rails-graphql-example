module Queries
  class Post < Queries::BaseQuery
    description 'Find a post by ID'

    argument :id, ID, required: true

    type Types::PostType, null: false

    def resolve(id:)
      ::Post.find(id)
    end
  end
end
