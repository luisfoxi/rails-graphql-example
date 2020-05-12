module Types
  class PostType < Types::BaseObject

    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :user, Types::UserType, null: false, preload: :user
    field :comments, [Types::CommentType], null: false, preload: [{comments: [:user, {replies: [:user]}]}]
    field :created_at, String, null: false

  end
end
