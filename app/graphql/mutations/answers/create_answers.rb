module Mutations
  module Answers
    class CreateAnswers < BaseMutation

      description 'Respondendo uma pesquisa'

      argument :answers, [Types::Inputs::AnswerInputType], required: true

      field :IDs, [Integer], null: false

      def resolve(answers:)
        authenticate_user(role: 'adm')
        AnswersCreator.new(answers, context[:current_user].id).create_answers
      end
    end
  end
end
