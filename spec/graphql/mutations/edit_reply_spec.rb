require "rails_helper"

RSpec.describe Mutations::EditReply do
  describe "edit a reply" do
    let(:user) { create(:user) }
    let(:comment_user) { create(:user) }
    let(:reply_user) { create(:user) }

    let(:post) { create(:post, user: user) }
    let(:comment) { create(:comment, user: comment_user, post: post) }
    let(:reply) { create(:reply, user: reply_user, comment: comment) }

    let(:reply_attributes) { attributes_for(:reply) }

    let(:mutation) do
      %(
        mutation {
          editReply(
            input:{
              id: #{reply.id}
              attributes: {
                body: "#{reply_attributes[:body]}"
              }
            }
          )
          {
            reply {
              body
              user {
                firstName
                lastName
                email
              }
              comment {
                user {
                  email
                }
              }
            }
          }
        }
      )
    end

    let(:expected_results) do
      {
        "body" => reply_attributes[:body],
        "user" => {
          "firstName" => reply_user.first_name,
          "lastName" => reply_user.last_name,
          "email" => reply_user.email
        },
        "comment" => {
          "user" => {
            "email" => comment_user.email,
          }
        }
      }
    end

    let(:context) { { current_user: reply_user } }

    let(:result) do
      result = GraphqlApiSchema.execute(mutation, context: context).as_json
    end

    it "should edit a reply" do
      expect(result.dig("data", "editReply", "reply")).to eq(expected_results)
    end
  end
end
