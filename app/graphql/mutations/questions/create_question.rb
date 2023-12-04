module Mutations
  module Questions
    class CreateQuestion < BaseMutation

      description 'Criando uma questão'

      argument :question, Types::Inputs::QuestionInputType, required: true

      field :question, Types::QuestionType, null: false

      def resolve(question:)
        authenticate_user(role: 'adm')
        question = Question.new(name: question.name, options_answer: question.options_answer, survey_id: question.survey_id, type_question: question.type_question)
        if question.save
          {question: question}
        else
          raise GraphQL::ExecutionError.new(question.errors.full_messages.join(', '))
        end
      end
    end
  end
end
