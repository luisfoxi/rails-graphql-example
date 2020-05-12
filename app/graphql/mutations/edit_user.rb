# frozen_string_literal: true

module Mutations
  class EditUser < Mutations::BaseMutation
    graphql_name "EditUser"

    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :email, String, required: false

    field :user, Types::UserType, null: false

    def resolve(args)
      authorize_user
      user = context[:current_user]
      user.update(args)
      MutationResult.call(
        obj: { user: user },
        success: user.persisted?,
        errors: user.errors
      )
    rescue ActiveRecord::RecordInvalid => invalid
      GraphQL::ExecutionError.new(
        "Invalid Attributes for #{invalid.record.class.name}: " \
        "#{invalid.record.errors.full_messages.join(', ')}"
      )
    end
  end
end
