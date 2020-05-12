module Types
  class CommentType < Types::BaseObject

    field :id, ID, null: false
    field :body, String, null: false
    field :user, Types::UserType, null: false, preload: :user
    field :post, Types::PostType, null: false, preload: :post
    field :replies, [Types::ReplyType], null: false, preload: :replies
    field :created_at, String, null: false

  end
end
