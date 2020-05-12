
module Queries
  class Posts < Queries::BaseQuery
    description 'list all posts'
    type Types::PostType.connection_type, null: false


    def resolve
      ::Post.all.order(created_at: :desc)
    end
  end
end
