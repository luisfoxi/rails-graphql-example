module Types
  class QueryType < Types::BaseObject

    field :users, resolver: Queries::Users
    field :user, resolver: Queries::User
    field :posts, resolver: Queries::Posts
    field :post, resolver: Queries::Post

    field :me, resolver: Queries::Me

  end
end
