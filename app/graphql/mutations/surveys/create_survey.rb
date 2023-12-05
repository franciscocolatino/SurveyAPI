module Mutations
  module Surveys
    class CreateSurvey < BaseMutation

      description 'Criando uma pesquisa'

      input_object_class Types::Inputs::Surveys::CreateInputType

      field :survey, Types::SurveyType, null: false

      def resolve(**arguments)
        authenticate_user(role: 'adm')
        SurveyUpdater.new(arguments, context[:current_user].id).call
      end
    end
  end
end
