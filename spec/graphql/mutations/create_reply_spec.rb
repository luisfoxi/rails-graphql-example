require "rails_helper"

RSpec.describe Mutations::CreateReply do
  describe "create a valid reply" do
    let(:user) { create(:user) }
    let(:comment_user) { create(:user) }
    let(:reply_user) {create(:user) }

    let(:post) { create(:post, user: user) }

    let(:comment) { create(:comment, post: post, user: comment_user)}

    let(:reply) { attributes_for(:reply)}

    let(:mutation) do
      %(
        mutation {
          createReply(
            input:{
              commentId: #{comment.id}
              attributes: {
                body: "#{reply[:body]}"
              }
            }
          )
          {
            reply {
              body
              comment{
                user{
                  firstName
                }
              }
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
        "body" => reply[:body],
        "comment" => {
          "user" =>{
            "firstName" => comment_user.first_name
          }
        },
        "user" => {
          "firstName" => reply_user.first_name,
          "lastName" => reply_user.last_name,
          "email" => reply_user.email
        }
      }
    end

    let(:context) { { current_user: reply_user } }

    let(:result) do
      result = GraphqlApiSchema.execute(mutation, context: context).as_json
    end

    it "should edit a post" do
      expect(result.dig("data", "createReply", "reply")).to eq(expected_results)
    end
  end
end
