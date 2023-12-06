module Mutations
  module Questions
    class UpdateQuestion < BaseMutation

      description 'Atualize uma questão específica'

      input_object_class Types::Inputs::Questions::UpdateInputType

      field :question, Types::QuestionType, null: false

      def resolve(**arguments)
        authenticate_user(role: 'adm')
        QuestionUpdater.new(arguments).call
      end
    end
  end
end
