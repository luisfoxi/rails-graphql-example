
require "rails_helper"

RSpec.describe Mutations::RegisterUser do
  describe "Register w/proper data" do
    let(:user_attrs) { attributes_for(:user) }

    let(:mutation) do
      %(mutation{
        registerUser(
          input:{
            firstName: "#{user_attrs[:first_name]}",
            lastName: "#{user_attrs[:last_name]}",
            email: "#{user_attrs[:email]}",
            password: "#{user_attrs[:password]}"
          }
        )
        {
          user {
            email
            authenticationToken
          }
        }
      })
    end

    subject(:result) do
      GraphqlApiSchema.execute(mutation).as_json
    end

    it "should register user" do
      expect(result.dig("data", "registerUser", "user")).to include({
        "email" => user_attrs[:email]
      })
    end
  end

  describe "register w/ invalid data" do
    let(:user_attrs) { { email: Faker::Internet.email, password: "123123" } }
    let(:mutation) do
      %(mutation{
        registerUser(
          input:{
            email: "#{user_attrs[:email]}",
            password: "#{user_attrs[:password]}"
          }
        )
        {
          user {
            email
            authenticationToken
          }
        }
      })
    end
    subject(:result) do
      GraphqlApiSchema.execute(mutation).as_json
    end

    it "should return error" do
      expect(result.dig("errors")).to_not be_empty
    end
  end
end
