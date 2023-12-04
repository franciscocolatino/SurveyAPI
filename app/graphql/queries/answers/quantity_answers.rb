module Queries
  module Answers
    class QuantityAnswers < Queries::BaseQuery

      argument :survey_id, ID, required: true

      type [Types::AnswerCountType], null: false

      def resolve(survey_id: nil)
        begin
          authenticate_user(role: 'adm')
          Answer.select(
            'surveys.id AS survey_id',
            'questions.name AS question_name',
            'answers.answer AS answer',
            'COUNT(*) AS quantity'
          ).joins(:question, :survey)
          .group('surveys.id, answers.answer, questions.name').where(survey_id: survey_id)
        rescue ActiveRecord::RecordNotFound => e
          raise GraphQL::ExecutionError.new(e.message)
        rescue StandardError => e
          raise GraphQL::ExecutionError.new(e.message)
        end
      end
    end
  end
end
