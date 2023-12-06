module Queries
  module Answers
    class AllQuantityAnswers < Queries::BaseQuery

      type [Types::AnswerCountType], null: false

      def resolve()
        authenticate_user(role: 'adm')
        AnswersQuantifier.new(nil).call
      end
    end
  end
end
