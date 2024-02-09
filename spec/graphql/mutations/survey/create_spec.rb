require "rails_helper"

RSpec.describe "creating a survey" do
  fixtures :users
  let(:user) { users(:test) }

  deadline = (Date.today + 5.days).strftime('%Y-%m-%dT%H:%M:%SZ')

  it "created with success" do
    result = SurveyApiSchema.execute(create_query, variables: {
      title: "Pesquisa teste 1",
      closed: false,
      deadline: deadline
    }, context: { current_user: user })
    expect(result.dig("data", "createSurvey", "survey", "title")).to eq("Pesquisa teste 1")
    expect(result.dig("data", "createSurvey", "survey", "closed")).to eq(false)
    expect(result.dig("data", "createSurvey", "survey", "deadline")).to eq(deadline)
  end

  it "returns an error when not authenticated" do
    result = SurveyApiSchema.execute(create_query, variables: {
      title: "Pesquisa teste 1",
      closed: false,
      deadline: deadline
    })
    expect(result.dig("data", "createSurvey")).to be_nil
    expect(result["errors"].first["message"]).not_to be_blank
  end

  def create_query
    <<~GQL
      mutation createSurvey($title: String!, $closed: Boolean!, $deadline: ISO8601DateTime!) {
        createSurvey(input: {
          title: $title
          closed: $closed
          deadline: $deadline
        }) {
          survey {
            id
            title
            closed
            deadline
          }
        }
      }
    GQL
  end
end
