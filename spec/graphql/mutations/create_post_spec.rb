require "rails_helper"

RSpec.describe Mutations::CreatePost do
  describe "create a valid post" do
    let(:user) { create(:user) }

    let(:post) { attributes_for(:post) }
    let(:mutation) do
      %(
        mutation {
          createPost(
            input:{
              attributes: {
                title: "#{post[:title]}",
                body: "#{post[:body]}"
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
        "body" => post[:body],
        "title" => post[:title],
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

    it "should create post" do
      expect(result.dig("data", "createPost", "post")).to eq(expected_results)
    end
  end
end
