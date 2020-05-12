require "rails_helper"

RSpec.describe Queries::Posts do
  describe "posts" do
    let!(:users) { create_list(:user, rand(1..10)) }
    let!(:posts) { create_list(:post, rand(1..10), user: users.sample(1)[0]) }

    let(:query) do
      %(query {
        posts {
          nodes{
            title
            body
            user{
              firstName
              lastName
            }
          }
        }
      })
    end

    subject(:result) do
      GraphqlApiSchema.execute(query).as_json
    end

    it "should return the created post" do
      expect(result.dig("data", "posts", "nodes")).to match_array(
        posts.map do |post|
          {
            "title" => post.title,
            "body" => post.body,
            "user" => {
              "firstName" => post.user.first_name,
              "lastName" => post.user.last_name
            }
          }
        end
      )
    end
  end
end
