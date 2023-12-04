# frozen_string_literal: true

module Types
  class AnswerCountType < Types::BaseObject

    field :survey_id, Integer, null: false
    field :question_name, String, null: false
    field :answer, String, null: false
    field :quantity, Integer, null: false
  end
end
