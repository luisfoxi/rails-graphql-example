require "rails_helper"

RSpec.describe Queries::Users do
  describe "users" do
    let!(:users) { create_list(:user, rand(1..10)) }

    let(:query) do
      %(query {
        users {
          nodes{
            firstName
            lastName
            email
          }
        }
      })
    end

    subject(:result) do
      GraphqlApiSchema.execute(query).as_json
    end

    it "returns all items" do
      expect(result.dig("data", "users", "nodes")).to match_array(
        users.map { |user| { "email" => user.email, "firstName" => user.first_name, "lastName" => user.last_name } }
      )
    end
  end
end
