module Mutations
  module Surveys
    class CreateSurvey < BaseMutation

      description 'Criando uma pesquisa'

      argument :title, String, required: true
      argument :closed, Boolean, required: true
      argument :deadline, GraphQL::Types::ISO8601DateTime, required: true

      field :survey, Types::SurveyType, null: false

      def resolve(title:, closed:, deadline:)
        authenticate_user(role: 'adm')
        survey = Survey.new(title: title, closed: closed, deadline: deadline, user_id: context[:current_user].id)
        if survey.save
          {survey: survey}
        else
          raise GraphQL::ExecutionError.new(survey.errors.full_messages.join(', '))
        end
      end
    end
  end
end
