# frozen_string_literal: true

module Mutations
  class CreatePost < Mutations::BaseMutation
    graphql_name "CreatePost"

    argument :attributes, Types::PostAttributes, required: true

    field :post, Types::PostType, null: false

    def resolve(attributes:)
      authorize_user
      user = context[:current_user]
      post = user.posts.create(attributes.to_h)
      MutationResult.call(
        obj: { post: post },
        success: post.persisted?,
        errors: post.errors
      )
    rescue ActiveRecord::RecordInvalid => invalid
      GraphQL::ExecutionError.new(
        "Invalid Attributes for #{invalid.record.class.name}: " \
        "#{invalid.record.errors.full_messages.join(', ')}"
      )
    end
  end
end
