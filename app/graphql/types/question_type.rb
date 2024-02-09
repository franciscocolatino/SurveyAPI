# frozen_string_literal: true

module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :survey_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :type_question, Types::Enums::QuestionEnumType, null: true
    field :formmated_type_question, String, null: true
    field :options_answer, [String], null: false

    def formmated_type_question
      Question::TYPE_QUESTION[object.type_question]
    end
    # def answer
    #   if context[:current_user].role == 'user'
    #     raise GraphQL::ExecutionError.new(I18n.t('errors.users.noPermission'))
    #   else
    #     object.answer
    #   end
  end
end
