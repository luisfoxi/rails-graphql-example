module Types
  class ReplyType < Types::BaseObject

    field :id, ID, null: false
    field :body, String, null: false
    field :user, Types::UserType, null: false, preload: :user
    field :comment, Types::CommentType, null: false, preload: [{comment: [:user, :post]}, :user]

  end
end
