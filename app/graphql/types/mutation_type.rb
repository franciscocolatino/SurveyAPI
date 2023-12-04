# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World"
    # end
    field :create_user, mutation: Mutations::Users::CreateUser

    field :login_user, mutation: Mutations::Users::LoginUser

    field :create_survey, mutation: Mutations::Surveys::CreateSurvey
    field :update_survey, mutation: Mutations::Surveys::UpdateSurvey

    field :create_question, mutation: Mutations::Questions::CreateQuestion
    field :update_question, mutation: Mutations::Questions::UpdateQuestion

    field :create_answers, mutation: Mutations::Answers::CreateAnswers


  end
end
