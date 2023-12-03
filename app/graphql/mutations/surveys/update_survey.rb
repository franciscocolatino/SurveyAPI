module Mutations
  module Surveys
    class UpdateSurvey < BaseMutation
      require 'json_web_token'

      description 'Atualize uma pesquisa específica'

      argument :id, ID, required: true
      argument :title, String, required: false
      argument :closed, Boolean, required: false
      argument :deadline, GraphQL::Types::ISO8601DateTime, required: false

      field :survey, Types::SurveyType, null: false

      def resolve(id:, title: nil, closed: nil, deadline: nil)
        authenticate_user(role: 'adm')
        survey = Survey.find(id)

        #Tentar melhorar
        survey.title = title if title.present?
        survey.closed = closed if closed != nil
        survey.deadline = deadline if deadline.present?

        if survey.save
          {survey: survey}
        else
          raise GraphQL::ExecutionError.new(survey.errors.full_messages.join(', '))
        end
      end
    end
  end
end
