module Mutations
  module Questions
    class CreateQuestion < BaseMutation

      description 'Criando uma questão'

      argument :name, String, required: true
      argument :options_answer, [String], required: true
      argument :survey_id, Integer, required: true
      argument :type_question, String, required: true

      field :question, Types::QuestionType, null: false

      def resolve(name:, options_answer:, survey_id:, type_question:)
        # authenticate_user(role: 'adm')
        question = Question.new(name: name, options_answer: options_answer, survey_id: survey_id, type_question: type_question)
        if question.save
          {question: question}
        else
          raise GraphQL::ExecutionError.new(question.errors.full_messages.join(', '))
        end
      end
    end
  end
end
