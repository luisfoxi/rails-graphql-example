require "rails_helper"

RSpec.describe Queries::User do
  describe "user" do
    let!(:user) {create(:user)}
    let(:query) do
      %(query {
        user(id: "#{user.id}") {
          firstName
          lastName
          email
        }
      })
    end

    subject(:result) do
      GraphqlApiSchema.execute(query).as_json
    end

    it "should return user" do
      expect(result.dig("data", "user")).to match(
        {"email" => user.email, "firstName" => user.first_name, "lastName" => user.last_name}
      )
    end
  end
end
