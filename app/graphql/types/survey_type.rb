# frozen_string_literal: true

module Types
  class SurveyType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :closed, Boolean
    field :user_id, Integer, null: false
    field :question, [Types::QuestionType]
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :deadline, GraphQL::Types::ISO8601DateTime
  end
end
