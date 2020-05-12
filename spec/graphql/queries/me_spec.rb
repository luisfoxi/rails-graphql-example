require "rails_helper"

RSpec.describe Queries::Me, type: :request do
  describe "me" do
    let!(:user) { create(:user) }

    let(:query) do
      %(query {
        me {
          email
          firstName
          lastName
        }
      })
    end

    subject(:result) do
      GraphqlApiSchema.execute(query, context: {current_user: user}).as_json
    end

    it "should return the profile" do
      expect(result.dig("data", "me")).to match(
        { "firstName" => user.first_name, "lastName" => user.last_name, "email" => user.email }
      )
    end
  end

  describe "test /graphql endpoint with me query" do
    let(:user) { create(:user) }
    let(:headers) { { "Authorization" => "Bearer #{user.authentication_token}" } }

    let(:query_string) { "{ me { email } }" }

    let(:expected_response) do
      {
        "data" => {
          "me" => {
            "email" => user.email
          }
        }
      }
    end
    it "should return my email" do
      post '/graphql', params: { query: query_string }, headers: headers
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end
end
