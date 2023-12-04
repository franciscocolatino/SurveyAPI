module Mutations
  module Questions
    class UpdateQuestion < BaseMutation

      description 'Atualize uma questão específica'

      input_object_class Types::Inputs::Questions::UpdateInputType

      field :question, Types::QuestionType, null: false

      def resolve(**arguments)
        authenticate_user(role: 'adm')
        question = Question.find(arguments[:id])

        question.update!(arguments.to_hash)
        { question: question}
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.full_messages.join(', '))
      end
    end
  end
end
