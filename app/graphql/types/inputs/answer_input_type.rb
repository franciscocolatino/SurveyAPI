module Types
  module Inputs
    class AnswerInputType < GraphQL::Schema::InputObject
      argument :survey_id, Int, required: true
      argument :question_id, Int, required: true
      argument :answer, String, required: true
    end
  end
end
