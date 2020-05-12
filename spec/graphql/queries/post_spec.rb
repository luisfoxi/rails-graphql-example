require "rails_helper"

RSpec.describe Queries::Post do
  describe "post" do
    let!(:user) {create(:user)}
    let!(:post) {create(:post, user: user)}

    let(:query) do
      %(query {
        post(id: "#{post.id}") {
          title
          body
          user{
            firstName
            lastName
          }
        }
      })
    end

    subject(:result) do
      GraphqlApiSchema.execute(query).as_json
    end

    it "should return the created post" do
      expect(result.dig("data", "post")).to match(
        {"title" => post.title, "body" => post.body, "user" => {"firstName" => user.first_name, "lastName" =>user.last_name}}
      )
    end
  end
end
