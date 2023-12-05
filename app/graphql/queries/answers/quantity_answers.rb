module Queries
  module Answers
    class QuantityAnswers < Queries::BaseQuery

      argument :survey_id, ID, required: true

      type [Types::AnswerCountType], null: false

      def resolve(survey_id:)
        authenticate_user(role: 'adm')
        AnswerQuantifier.new(survey_id).call
      end
    end
  end
end
