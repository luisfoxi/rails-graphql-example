require "rails_helper"

RSpec.describe Mutations::CreateComment do
  describe "create a valid post" do
    let(:user) { create(:user) }
    let(:comment_user) { create(:user) }

    let(:post) { create(:post, user: user) }

    let(:comment) { attributes_for(:comment)}
    let(:mutation) do
      %(
        mutation {
          createComment(
            input:{
              postId: #{post.id}
              attributes: {
                body: "#{comment[:body]}"
              }
            }
          )
          {
            comment {
              body
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
        "body" => comment[:body],
        "user" => {
          "firstName" => comment_user.first_name,
          "lastName" => comment_user.last_name,
          "email" => comment_user.email
        }
      }
    end

    let(:context) { { current_user: comment_user } }

    let(:result) do
      result = GraphqlApiSchema.execute(mutation, context: context).as_json
    end

    it "should edit a post" do
      expect(result.dig("data", "createComment", "comment")).to eq(expected_results)
    end
  end
end
