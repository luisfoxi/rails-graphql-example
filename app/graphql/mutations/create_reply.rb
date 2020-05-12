# frozen_string_literal: true

module Mutations
  class CreateReply < Mutations::BaseMutation
    graphql_name "CreateReply"

    argument :comment_id, ID, required: true
    argument :attributes, Types::ReplyAttributes, required: true

    field :reply, Types::ReplyType, null: false

    def resolve(comment_id:, attributes:)
      authorize_user

      comment = Comment.find(comment_id)
      reply = comment.replies.create(attributes.to_h.merge(user: context[:current_user]))
      MutationResult.call(
        obj: { reply: reply },
        success: reply.persisted?,
        errors: reply.errors
      )
    rescue ActiveRecord::RecordInvalid => invalid
      GraphQL::ExecutionError.new(
        "Invalid Attributes for #{invalid.record.class.name}: " \
        "#{invalid.record.errors.full_messages.join(', ')}"
      )
    end
  end
end
