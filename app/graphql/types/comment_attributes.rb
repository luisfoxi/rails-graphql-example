module Types
  class CommentAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a comment"

    argument :body, String, required: true
  end
end
