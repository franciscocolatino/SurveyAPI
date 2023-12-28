require "rails_helper"

RSpec.describe "mutation register" do
  it "creating the account and returning a token and user" do
    result = SurveyApiSchema.execute(register_query, variables: {
      username: "testingNewUser",
      password: "1234",
      role: "adm"
    })
    expect(result.dig("data", "createUser", "token")).not_to be_blank
    expect(result.dig("data", "createUser", "user", "username")).to eq("testingNewUser")
  end


  it "return an error when username is exists" do
    result = SurveyApiSchema.execute(register_query, variables: {
      username: "testing",
      password: "12345678",
      role: "adm"
    })
    expect(result.dig("data", "createUser")).to be_nil
    expect(result["errors"].first["message"]).not_to be_blank
  end

  def register_query
    <<~GQL
      mutation createUser($username: String!, $password: String!, $role: String!) {
        createUser(input: {
          username: $username
          password: $password
          role: $role
        }) {
          token
          user {
            id
            username
            role
          }
        }
      }
    GQL
  end
end
