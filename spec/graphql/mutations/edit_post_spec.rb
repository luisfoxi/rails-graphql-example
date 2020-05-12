require "rails_helper"

RSpec.describe Mutations::EditPost do
  describe "create a valid post" do
    let(:user) { create(:user) }

    let(:post) { create(:post, user: user) }
    let(:post_attributes) {attributes_for(:post)}
    let(:mutation) do
      %(
        mutation {
          editPost(
            input:{
              id: #{post.id}
              attributes: {
                title: "#{post_attributes[:title]}",
                body: "#{post_attributes[:body]}"
              }
            }
          )
          {
            post {
              body
              title
              user{
                firstName
                lastName
                email
              }
            }
          }
        }
      )
    end

    let(:expected_results) do
      {
        "body" => post_attributes[:body],
        "title" => post_attributes[:title],
        "user" => {
          "firstName" => user.first_name,
          "lastName" => user.last_name,
          "email" => user.email
        }
      }
    end

    let(:context) { { current_user: user } }

    let(:result) do
      result = GraphqlApiSchema.execute(mutation, context: context).as_json
    end

    it "should edit a post" do
      expect(result.dig("data", "editPost", "post")).to eq(expected_results)
    end
  end
end
