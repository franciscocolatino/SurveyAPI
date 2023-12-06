module Mutations
  module Questions
    class CreateQuestion < BaseMutation

      description 'Criando uma questão'

      input_object_class Types::Inputs::Questions::CreateInputType

      field :question, Types::QuestionType, null: false

      def resolve(**arguments)
        authenticate_user(role: 'adm')
        QuestionCreator.new(arguments).call
      end
    end
  end
end
