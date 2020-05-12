# frozen_string_literal: true

module Mutations
  class EditReply < Mutations::BaseMutation
    graphql_name "EditReply"

    argument :id, ID, required: true
    argument :attributes, Types::ReplyAttributes, required: true

    field :reply, Types::ReplyType, null: false

    def resolve(id:, attributes:)
      authorize_user
      user = context[:current_user]
      reply = user.replies.find(id)
      reply.update(attributes.to_h)

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
