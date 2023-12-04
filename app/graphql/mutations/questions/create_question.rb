module Mutations
  module Questions
    class CreateQuestion < BaseMutation

      description 'Criando uma questão'

      input_object_class Types::Inputs::Questions::CreateInputType

      field :question, Types::QuestionType, null: false

      def resolve(**arguments)
        authenticate_user(role: 'adm')
        question = Question.new(arguments.to_hash)
        if question.save
          {question: question}
        else
          raise GraphQL::ExecutionError.new(question.errors.full_messages.join(', '))
        end
      end
    end
  end
end
