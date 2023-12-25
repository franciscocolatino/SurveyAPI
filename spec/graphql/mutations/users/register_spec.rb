require "rails_helper"

RSpec.describe "mutation register" do
  it "creating the account and returning a token" do
    query = <<~GQL
      mutation {
        createUser(input: {
          username: "chico2"
          password: "1234"
          role: "adm"
        }) {
          token
        }
      }
    GQL
    result = SurveyApiSchema.execute(query)
  end
end
