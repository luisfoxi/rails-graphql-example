module Types
  class ReplyAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a reply"

    argument :body, String, required: true
  end
end
