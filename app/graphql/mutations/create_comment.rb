# frozen_string_literal: true

module Mutations
  class CreateComment < Mutations::BaseMutation
    graphql_name "CreateComment"

    argument :post_id, ID, required: true
    argument :attributes, Types::CommentAttributes, required: true

    field :comment, Types::CommentType, null: false

    def resolve(post_id:, attributes:)
      authorize_user

      post = Post.find(post_id)
      comment = post.comments.create(attributes.to_h.merge(user: context[:current_user]))
      MutationResult.call(
        obj: { comment: comment },
        success: comment.persisted?,
        errors: comment.errors
      )
    rescue ActiveRecord::RecordInvalid => invalid
      GraphQL::ExecutionError.new(
        "Invalid Attributes for #{invalid.record.class.name}: " \
        "#{invalid.record.errors.full_messages.join(', ')}"
      )
    end
  end
end
