module Queries
  module Answers
    class AllQuantityAnswers < Queries::BaseQuery

      type [Types::AnswerCountType], null: false

      def resolve()
        begin
          authenticate_user(role: 'adm')
          Answer.select(
            'surveys.id AS survey_id',
            'questions.name AS question_name',
            'answers.answer AS answer',
            'COUNT(*) AS quantity'
          ).joins(:question, :survey)
          .group('surveys.id, answers.answer, questions.name')
          .order('surveys.id')
        rescue ActiveRecord::RecordNotFound => e
          raise GraphQL::ExecutionError.new(e.message)
        rescue StandardError => e
          raise GraphQL::ExecutionError.new(e.message)
        end
      end
    end
  end
end
