# frozen_string_literal: true

module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :survey_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :type_question, String
    field :options_answer, [String], null: false
    
    # def answer
    #   if context[:current_user].role == 'user'
    #     raise GraphQL::ExecutionError.new(I18n.t('errors.users.noPermission'))
    #   else
    #     object.answer
    #   end
  end
end
