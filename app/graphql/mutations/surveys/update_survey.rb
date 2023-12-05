module Mutations
  module Surveys
    class UpdateSurvey < BaseMutation
      require 'json_web_token'

      description 'Atualize uma pesquisa específica'

      input_object_class Types::Inputs::Surveys::UpdateInputType

      field :survey, Types::SurveyType, null: false

      def resolve(**arguments)
        authenticate_user(role: 'adm')
        SurveyUpdater.new(arguments, context[:current_user].id).call
      end
    end
  end
end
