require "rails_helper"

RSpec.describe "mutation login" do
  fixtures :users

  it "authenticates the account returning a token" do
    result = SurveyApiSchema.execute(login_query, variables: {
      username: "testing",
      password: "1234"
    })
    expect(result.dig("data", "loginUser", "token")).not_to be_blank
  end

  it "returns an error when authentication fails" do
    result = SurveyApiSchema.execute(login_query, variables: {
      username: "testing",
      password: "123"
    })
    expect(result.dig("data", "loginUser")).to be_nil
    expect(result["errors"].first["message"]).to eq("Usuário ou senha inválido!")
  end

  def login_query
    <<~GQL
      mutation LoginUser($username: String!, $password: String!) {
        loginUser(input: {
          username: $username
          password: $password
        }) {
          token
        }
      }
    GQL
  end
end
