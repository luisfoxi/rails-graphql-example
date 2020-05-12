# frozen_string_literal: true

module Mutations
  class EditComment < Mutations::BaseMutation
    graphql_name "EditComment"

    argument :id, ID, required: true
    argument :attributes, Types::CommentAttributes, required: true

    field :comment, Types::CommentType, null: false

    def resolve(id:, attributes:)
      authorize_user
      user = context[:current_user]
      comment = user.comments.find(id)
      comment.update(attributes.to_h)

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
