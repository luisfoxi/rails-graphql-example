module Types
  class PostAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a post"

    argument :title, String, required: false
    argument :body, String, required: false

  end
end
